{% if salt['pillar.get']('redis', false) %}
{% set app = salt['pillar.get']('redis') %}
{% if app.install.enabled %}
pkg-{{ app.name }}-install:
  pkg:
    - installed
    - sources:
      - {{ app.name }}: salt://redis/files/pkgs/redis-{{ app.install.version }}.el7.x86_64.rpm
{% endif %}
{% endif %}
