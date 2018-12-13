{% set app = salt['pillar.get']('kafka') %}

{{ app.user }}:
  group.present:
    - gid: {{ app.uid }}
  user.present:
    - uid: {{ app.uid }}
    - gid: {{ app.uid }}

zk-directories:
  file.directory:
    - user: kafka
    - group: kafka
    - mode: 755
    - makedirs: True
    - names:
      - /var/run/kafka
      - /var/lib/kafka
      - /var/log/kafka

{%- set alt_home             = app.prefix + '/kafka' %}
{%- set real_home            = alt_home + '_' + app.version %}

install-kafka:
  archive.extracted:
    - name: {{ app.prefix }}
    - source: {{ app.source_url }}
    - archive_format: tar
    - skip_verify: True
    - if_missing: {{ real_home }}/lib
    - user: root
    - group: root

kafka-home-link:
  file.symlink:
    - name: {{ alt_home }}
    - target: {{ real_home }}
    - require:
      - archive: install-kafka
