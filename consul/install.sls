{% if salt['pillar.get']('consul') %}
{% set app = salt['pillar.get']('consul') %}
consul-dep-unzip:
  pkg.installed:
    - name: unzip

{% set app = salt['grains.filter_by']({
        'armv6l': {
            "arch": 'arm'
        },
        'armv7l': {
            "arch": 'arm'
        },
        'x86_64': {
            "arch": 'amd64'
        }
  }
  ,grain="cpuarch"
  ,merge=app)
%}

consul-download:
  file.managed:
    - name: /tmp/consul_{{ app.version }}_linux_{{ app.arch }}.zip
    - source: https://{{ app.download_host }}/consul/{{ app.version }}/consul_{{ app.version }}_linux_{{ app.arch }}.zip
    - source_hash: https://releases.hashicorp.com/consul/{{ app.version }}/consul_{{ app.version }}_SHA256SUMS
    - unless: test -f /usr/local/bin/consul-{{ app.version }}

consul-extract:
  cmd.wait:
    - name: unzip /tmp/consul_{{ app.version }}_linux_{{ app.arch }}.zip -d /tmp
    - watch:
      - file: consul-download

consul-install:
  file.rename:
    - name: /usr/local/bin/consul-{{ app.version }}
    - source: /tmp/consul
    - watch:
      - cmd: consul-extract

consul-clean:
  file.absent:
    - name: /tmp/consul_{{ app.version }}_linux_{{ app.arch }}.zip
    - watch:
      - file: consul-install

consul-link:
  file.symlink:
    - target: consul-{{ app.version }}
    - name: /usr/local/bin/consul
    - watch:
      - file: consul-install

{% endif %}
