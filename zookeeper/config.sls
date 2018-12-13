{% if salt['pillar.get']('zookeeper') %}
{% set app = salt['pillar.get']('zookeeper') %}
{%- set alt_home = app.prefix + '/zookeeper' %}
{%- set real_home = alt_home + '-' + app.version %}
{%- set DataDir = app.config.data_dir + '/data' %}

/etc/zookeeper:
  file.directory:
    - user: root
    - group: root

zookeeper-data-dir:
  file.directory:
    - name: {{ DataDir }}
    - user: zookeeper
    - group: zookeeper
    - makedirs: True
{% if app.cluster.enable -%}
zookeeper-myid:
  file.managed:
    - name: {{ DataDir }}/myid
    - source: salt://zookeeper/files/conf/myid
    - user: zookeeper
    - group: zookeeper
    - template: jinja
{% endif %}

rsync-zookeeper-cfg:
  file.managed:
    - name: {{ app.config.directory }}/zoo.cfg
    - source: salt://zookeeper/files/conf/zoo.cfg
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - template: jinja

zookeeper-cfg-link:
  file.symlink:
    - name: {{real_home}}/conf/zoo.cfg
    - target: {{ app.config.directory }}/zoo.cfg
    - require:
      - file: rsync-zookeeper-cfg

{% endif %}
