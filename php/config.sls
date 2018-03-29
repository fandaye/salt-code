{% if salt['pillar.get']('php', false) %}

{% if salt['pillar.get']('php:dirs') %}
{% for dir , items in salt['pillar.get']('php:dirs').items() %}
mkdir-{{ dir }}:
  file.directory:
    - name: {{ dir }}
    {% for value in items.options %}
    - {{ value }}
    {% endfor %}
{% endfor %}
{% endif %}

{% if salt['pillar.get']('php:files') %}
{% for file , items in salt['pillar.get']('php:files').items() %}
rsync-file-{{ file }}:
  file.managed:
    - name: {{ file }}
    {% for value in items.options %}
    - {{ value }}
    {% endfor %}
{% endfor %}
{% endif %}

{% endif %}

