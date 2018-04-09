{% if salt['pillar.get']('elasticsearch') %}
{% set es = salt['pillar.get']('elasticsearch') %}

install-pkg-elasticsearch:
  pkg:
    - installed
    - sources:
      - elasticsearch: {{ es.source_url }} 

{% endif %}
