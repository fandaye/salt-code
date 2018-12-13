{% if salt['pillar.get']('kafka') %}
{% set app = salt['pillar.get']('kafka') %}
{%- set alt_home             = app.prefix + '/kafka' %}
{%- set real_home            = alt_home + '_' + app.version %}

/etc/kafka:
  file.directory:
    - user: root
    - group: root

rsync-kafka-cfg:
  file.managed:
    - name: {{ app.config.directory }}/server.properties
    - source: salt://kafka/files/conf/server.properties
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - template: jinja

{% endif %}
