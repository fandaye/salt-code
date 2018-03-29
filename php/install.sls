{% if salt['pillar.get']('php', false) %}
{% set app = salt['pillar.get']('php') %}
{% if app.install.enabled %}

repo-remi-{{ app.name }}-install:
  pkgrepo.managed:
    - name: {{ app.name }}-{{ app.install.version }}
    - humanname: {{ app.name }} Repository
    - mirrorlist: {{ app.install.download_host }}/enterprise/{{ grains['osmajorrelease'] }}/php{{ app.install.version | replace('.','')}}/mirror
    - gpgcheck: 0

repo-remi-install:
  pkgrepo.managed:
    - name: remi
    - humanname: Remi Repository
    - mirrorlist: {{ app.install.download_host }}/enterprise/{{ grains['osmajorrelease'] }}/remi/mirror
    - gpgcheck: 0

pkg-{{ app.name }}-install:
  pkg:
    - pkgs:
      {% for value in app.install.pkgs %}
      - {{ value }}
      {% endfor %}
    - installed


{% endif %}
{% endif %}
