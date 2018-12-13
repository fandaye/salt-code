{% if salt['pillar.get']('zookeeper') %}
{% set app = salt['pillar.get']('zookeeper') %}

/usr/lib/systemd/system/zookeeper.service:
  file.managed:
    - source: salt://zookeeper/files/usr/lib/systemd/system/zookeeper.service
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - template: jinja

running-service-{{ app.user }}:
  service.running:
    {% for value in app.running.options%}
    - {{ value }}
    {% endfor %}


{% endif %}
