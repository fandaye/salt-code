{% for ip, hosts in salt["pillar.get"]("hosts", {}).items() %}
add_hosts_{{ip}}:
  host.present:
    - ip: {{ip}}
    - names:
    {% for value in hosts %}
      - {{value}}
    {% endfor %}
{%endfor%}