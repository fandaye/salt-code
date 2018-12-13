# salt-code  Zookeeper
Saltstack 自动化部署 Zookeeper 及卸载 

Saltstack Version: 2018.3.3

测试环境：Centos 6/7

Pillar 变量说明：

> 参考：[pillar.example]()

```
zookeeper:
  user: zookeeper
  uid: 6030
  prefix: /usr/lib
  version: 3.4.10
  source_url: 'http://apache.mirror.globo.tech/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz'
  config:
    logdir: '/var/log/zookeeper'
    data_dir: '/data/zookeeper'
    directory: '/etc/zookeeper/conf'
    port: 2181
  cluster:
    enable: True  #是否启动集群
    hosts:
      node03: 1
      node04: 2
      node05: 3
  running:
    enabled: True
    options:
      - name: zookeeper
      - enable: True
      - reload: True
```