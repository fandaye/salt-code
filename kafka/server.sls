{% if salt['pillar.get']('kafka') %}
{% set app = salt['pillar.get']('kafka') %}

/usr/lib/systemd/system/kafka.service:
  file.managed:
    - source: salt://kafka/files/usr/lib/systemd/system/kafka.service
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
