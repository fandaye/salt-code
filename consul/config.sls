{% if salt['pillar.get']('consul') %}

{% if salt['pillar.get']('consul:dirs') %}
{% for dir , items in salt['pillar.get']('consul:dirs').items() %}
mkdir-{{ dir }}:
  file.directory:
    - name: {{ dir }}
    {% for value in items.options %}
    - {{ value }}
    {% endfor %}
{% endfor %}
{% endif %}

{% if salt['pillar.get']('consul:files') %}
{% for file , items in salt['pillar.get']('consul:files').items() %}
rsync-file-{{ file }}:
  file.managed:
    - name: {{ file }}
    {% for value in items.options %}
    - {{ value }}
    {% endfor %}
{% endfor %}
{% endif %}


{% endif %}
