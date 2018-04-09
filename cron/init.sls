{% if salt['pillar.get']('cron') %}

running-service-crond:
  service.running:
    - name: crond
    - enable: True
    - reload: True

{% for i,items in salt['pillar.get']("cron").items() %}
add-cron-{{i}}:
  cron.present:
    {% for value in items %}
    - {{value}}
    {% endfor %}
{% endfor %}
{% endif %}