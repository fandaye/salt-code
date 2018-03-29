{% if salt['pillar.get']('nginx', false) %}
{% set app = salt['pillar.get']('nginx') %}

disabled-service-nginx:
  service.dead:
    - name: nginx
    - enable: False

pkg-{{ app.name }}-install:
  pkg.purged:
    - pkgs:
      - {{ app.name }}

{% if salt['pillar.get']('php:dirs') %}
{% for dir , items in salt['pillar.get']('nginx:dirs').items() %}
remove-{{ dir }}:
  file.absent:
    - name: {{ dir }}
{% endfor %}
{% endif %}

remove-/etc/nginx:
  file.absent:
    - name: /etc/nginx

{% endif %}
