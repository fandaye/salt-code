# -- fan --

{% set config = salt['pillar.get']('etcd') -%}
{% set pkgname = 'etcd-v'+ config.version +'-'+ grains['kernel']|lower +'-amd64' %}

{% set bin_dir = config.bin_dir %}
{% set ca_dir = config.ca_dir %}

rsync-etcd-package: # 同步etcd二进制压缩包
  file.managed:
    - name: /tmp/{{ pkgname }}.tar.gz
    - source: salt://etcd/files/package/{{ pkgname }}.tar.gz

install-etcd: # 安装etcd
  cmd.run:
    - name: /usr/bin/tar -zxf /tmp/{{ pkgname }}.tar.gz -C /tmp && /usr/bin/cp /tmp/{{ pkgname }}/{etcd,etcdctl} /usr/bin/ && /usr/bin/rm -rf /tmp/{{ pkgname }}
    - unless: /usr/bin/ls {{ bin_dir }}/etcdctl && /usr/bin/ls {{ bin_dir }}/etcd
    - require:
      - file: rsync-etcd-package


rsync-ssl-file: # 同步证书文件 'ca-config.json','ca.csr','ca-key.pem','ca.csr'
  file.recurse:
    - name: {{ca_dir}}
    - source: salt://etcd/files/ssl
    - makedirs: True

rsync-etcd-csr-json: # 同步etcd证书配置文件
  file.managed:
    - name: {{ ca_dir }}/etcd-csr.json
    - source: salt://etcd/files/config/etcd-csr.json
    - template: jinja    

create-etcd-ssl:
  cmd.run:
    - name: {{ bin_dir }}/cfssl gencert -ca={{ ca_dir }}/ca.pem -ca-key={{ ca_dir }}/ca-key.pem -config={{ ca_dir }}/ca-config.json -profile=kubernetes {{ ca_dir }}/etcd-csr.json | {{ bin_dir }}/cfssljson -bare etcd
    - unless: {{bin_dir}}/ls {{ ca_dir }}/etcd-key.pem
    - cwd: {{ ca_dir }}
    - require:
      - file: rsync-etcd-csr-json
      - file: rsync-ssl-file

rsync-service:
  file.managed:
    - name: /etc/systemd/system/etcd.service
    - source: salt://etcd/files/config/etcd.service
    - template: jinja

running-service-etcd:
  service.running:
    - name: etcd
    - enable: True
    - reload: True
    - require:
      - file: rsync-service
      - cmd: create-etcd-ssl
