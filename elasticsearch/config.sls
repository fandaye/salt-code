{% if salt['pillar.get']('elasticsearch') %}
{% set es = salt['pillar.get']('elasticsearch') %}

{% if salt['pillar.get']('elasticsearch:config:dirs') %}
{% for dir , items in salt['pillar.get']('elasticsearch:config:dirs').items() %}
mkdir-{{ dir }}:
  file.directory:
    - name: {{ dir }}
    {% for value in items.options %}
    - {{ value }}
    {% endfor %}
{% endfor %}
{% endif %}


{% if salt['pillar.get']('elasticsearch:config:files') %}
{% for file , items in salt['pillar.get']('elasticsearch:config:files').items() %}
rsync-file-{{ file }}:
  file.managed:
    - name: {{ file }}
    {% for value in items.options %}
    - {{ value }}
    {% endfor %}
{% endfor %}
{% endif %}


{% endif %}
