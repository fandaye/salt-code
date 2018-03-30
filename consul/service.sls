{% if salt['pillar.get']('consul', false) %}
{% set app = salt['pillar.get']('consul') %}
{% if app.running.enabled %}
running-service-{{ app.name }}:
  service.running:
    {% for value in app.running.options%}
    - {{ value }}
    {% endfor %}
{% endif %}
{% endif %}

