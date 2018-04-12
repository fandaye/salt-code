{% if salt['pillar.get']('redis', false) %}
{% set app = salt['pillar.get']('redis') %}

{% if app.install.enabled %}
pkg-{{ app.name }}-uninstall:
  pkg.removed:
    - name: {{ app.name }}
{% endif %}

{% if salt['pillar.get']('redis:dirs') %}
{% for dir , items in salt['pillar.get']('redis:dirs').items() %}
deleted-{{ dir }}:
  file.absent:
    - name: {{ dir }}
{% endfor %}
{% endif %}


{% endif %}
