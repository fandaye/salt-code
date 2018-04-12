{% if salt['pillar.get']('redis', false) %}
{% set app = salt['pillar.get']('redis') %}
{% if app.running.enabled %}
running-service-{{ app.name }}:
  service.running:
    {% for value in app.running.options%}
    - {{ value }}
    {% endfor %}
{% endif %}
{% endif %}
