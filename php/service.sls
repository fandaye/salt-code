{% if salt['pillar.get']('php', false) %}
{% set app = salt['pillar.get']('php') %}
{% if app.running.enabled %}
running-service-{{ app.name }}:
  service.running:
    {% for value in app.running.options%}
    - {{ value }}
    {% endfor %}
{% endif %}
{% endif %}

