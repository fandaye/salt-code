{% if salt['pillar.get']('elasticsearch') %}
{% set es = salt['pillar.get']('elasticsearch') %}

running-service-{{ es.name }}:
  service.running:
    {% for value in es.running.options%}
    - {{ value }}
    {% endfor %}

{% endif %}
