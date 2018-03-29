{% if salt['pillar.get']('nginx', false) %}
{% set nginx_settings = salt['pillar.get']('nginx') %}
{% if nginx_settings.install.enabled %}
nginx:
  pkg:
    - name: nginx
    - installed
{% endif %}
{% endif %}
