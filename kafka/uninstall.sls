{% if salt['pillar.get']('kafka') %}
{% set app = salt['pillar.get']('kafka') %}
{%- set alt_home             = app.prefix + '/kafka' %}
{%- set real_home            = alt_home + '_' + app.version %}

remove_/var/run/kafka:
  file.absent:
    - name: /var/run/kafka

remove_/var/lib/kafka:
  file.absent:
    - name: /var/lib/kafka

remove_/var/log/kafka:
  file.absent:
    - name: /var/log/kafka


remove_{{real_home}}:
  file.absent:
    - name: {{real_home}}

remove_{{alt_home}}:
  file.absent:
    - name: {{alt_home}}

remove_{{app.config.directory}}:
  file.absent:
    - name: {{app.config.directory}}

disabled-service-kafka:
  service.dead:
    - name: kafka
    - enable: False

remove_/usr/lib/systemd/system/kafka.service:
  file.absent:
    - name: /usr/lib/systemd/system/kafka.service

remove_user:
  user.absent:
    - name: {{ app.user }}
    - purge: True
{% endif %}
