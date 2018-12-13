{% set app = salt['pillar.get']('zookeeper') %}
{%- set alt_home             = app.prefix + '/zookeeper' %}
{%- set real_home            = alt_home + '-' + app.version %}

remove_/var/run/zookeeper:
  file.absent:
    - name: /var/run/zookeeper

remove_/var/lib/zookeeper:
  file.absent:
    - name: /var/lib/zookeeper

remove_/var/log/zookeeper:
  file.absent:
    - name: /var/log/zookeeper


remove_{{real_home}}:
  file.absent:
    - name: {{real_home}}

remove_{{alt_home}}:
  file.absent:
    - name: {{alt_home}}


remove_{{app.config.directory}}:
  file.absent:
    - name: {{app.config.directory}}

remove_{{app.config.data_dir}}:
  file.absent:
    - name: {{app.config.data_dir}}

disabled-service-zookeeper:
  service.dead:
    - name: zookeeper
    - enable: False

remove_/usr/lib/systemd/system/zookeeper.service:
  file.absent:
    - name: /usr/lib/systemd/system/zookeeper.service

remove_user:
  user.absent:
    - name: {{ app.user }}
    - purge: True

remove_group:
  group.absent:
    - name: {{ app.user }}
