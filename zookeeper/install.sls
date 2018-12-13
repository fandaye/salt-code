{% set app = salt['pillar.get']('zookeeper') %}

{{ app.user }}:
  group.present:
    - gid: {{ app.uid }}
  user.present:
    - uid: {{ app.uid }}
    - gid: {{ app.uid }}

zk-directories:
  file.directory:
    - user: zookeeper
    - group: zookeeper
    - mode: 755
    - makedirs: True
    - names:
      - /var/run/zookeeper
      - /var/lib/zookeeper
      - /var/log/zookeeper

{%- set alt_home = app.prefix + '/zookeeper' %}
{%- set real_home = alt_home + '-' + app.version %}

install-zookeeper:
  archive.extracted:
    - name: {{ app.prefix }}
    - source: {{ app.source_url }}
    - archive_format: tar
    - if_missing: {{ real_home }}/lib
    - skip_verify: True
    - user: root
    - group: root

zookeeper-home-link:
  file.symlink:
    - name: {{ alt_home }}
    - target: {{ real_home }}
    - require:
      - archive: install-zookeeper
