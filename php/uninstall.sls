{% if salt['pillar.get']('php', false) %}
{% set app = salt['pillar.get']('php') %}

disabled-service-php-fpm:
  service.dead:
    - name: php-fpm
    - enable: False

repo-remi-{{ app.name }}-install:
  pkgrepo.absent:
    - name: {{ app.name }}-{{ app.install.version }}

repo-remi-install:
  pkgrepo.absent:
    - name: remi

pkg-{{ app.name }}-install:
  pkg.purged:
    - pkgs:
      {% for value in app.install.pkgs %}
      - {{ value }}
      {% endfor %}

{% if salt['pillar.get']('php:dirs') %}
{% for dir , items in salt['pillar.get']('php:dirs').items() %}
remove-{{ dir }}:
  file.absent:
    - name: {{ dir }}
{% endfor %}
{% endif %}


{% if salt['pillar.get']('php:files') %}
{% for file , items in salt['pillar.get']('php:files').items() %}
remove-file-{{ file }}:
  file.absent:
    - name: {{ file }}
{% endfor %}
{% endif %}


{% endif %}
