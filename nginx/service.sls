{% if salt['pillar.get']('nginx', false) %}
{% set app = salt['pillar.get']('nginx') %}
{% if app.running.enabled %}
running-service-{{ app.name }}:
  service.running:
    {% for value in app.running.options%}
    - {{ value }}
    {% endfor %}
{% endif %}
{% endif %}
