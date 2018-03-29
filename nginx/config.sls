{% set nginx_settings = salt['pillar.get']('nginx') %}

{% if nginx_settings.dirs %}
{% for dir ,items in salt['pillar.get']("nginx:dirs").items() %}
mkdir_{{ dir }}:
  file.directory:
    - name: {{ dir }}
    {% for value in items.options %}
    - {{ value }}
    {% endfor %}
{% endfor %}
{% endif %}

{% if nginx_settings.files %}
{% for file ,items in salt['pillar.get']("nginx:files").items() %}
rsync_{{ file }}:
  file.managed:
    - name: {{ file }}
    - source: {{items.source}}
    {% for value in items.options %}
    - {{ value }}
    {% endfor %}
{% endfor %}
{% endif %}


{% set code_dir = salt['pillar.get']('nginx:code_dir', '/data/web') %}
{% if nginx_settings.nginx_servers %}
{% for server  in salt['pillar.get']("nginx:nginx_servers") %}
mkdir_{{ server }}:
  file.directory:
    - name: {{ code_dir }}/{{ server }}/www
    - makedirs: True 
rsync_{{ server }}:
  file.managed:
    - name: /etc/nginx/sites/{{ server }}.conf
    - source: salt://nginx/files/etc/nginx/sites/{{ server }}.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644    

{% endfor %}
{% endif %}

/etc/nginx/certs/:
  file.recurse:
    - source: salt://nginx/files/etc/nginx/certs/
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - include_empty: True
