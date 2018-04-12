{% if salt['pillar.get']('elasticsearch', false) %}
{% set es = salt['pillar.get']('elasticsearch') %}

pkg-{{ es.name }}-uninstall:
  pkg.removed:
    - name: {{ es.name }}

{% if salt['pillar.get']('elasticsearch:dirs') %}
{% for dir , items in salt['pillar.get']('elasticsearch:dirs').items() %}
deleted-{{ dir }}:
  file.absent:
    - name: {{ dir }}
{% endfor %}
{% endif %}


{% endif %}

