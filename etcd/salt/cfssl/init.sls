# -- fan --

install-cfssl: #  安装 cfssl
  file.managed:
    - name: /usr/bin/cfssl
    - source: https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
    - skip_verify: True
    - mode: 0755


install-cfssljson: # 安装 cfssljson
  file.managed:
    - name: /usr/bin/cfssljson
    - source: https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
    - skip_verify: True
    - mode: 0755
