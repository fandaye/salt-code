{% if salt['pillar.get']('redis', false) %}

{% if salt['pillar.get']('redis:dirs') %}
{% for dir , items in salt['pillar.get']('redis:dirs').items() %}
mkdir-{{ dir }}:
  file.directory:
    - name: {{ dir }}
    {% for value in items.options %}
    - {{ value }}
    {% endfor %}
{% endfor %}
{% endif %}

{% if salt['pillar.get']('redis:files') %}
{% for file , items in salt['pillar.get']('redis:files').items() %}
rsync-file-{{ file }}:
  file.managed:
    - name: {{ file }}
    {% for value in items.options %}
    - {{ value }}
    {% endfor %}
{% endfor %}
{% endif %}

{% endif %}
