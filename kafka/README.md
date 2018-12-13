# salt-code  Kfka
Saltstack 自动化部署 Kfka 及卸载 

Saltstack Version: 2018.3.3

测试环境：Centos 6/7

Pillar 变量说明：

> 参考：[pillar.example](https://github.com/fandaye/salt-code/blob/master/kafka/pillar.example)

```
kafka:
  user: kafka
  uid: 6031
  prefix: /usr/lib
  version: 2.11-2.1.0
  source_url: 'http://mirrors.hust.edu.cn/apache/kafka/2.1.0/kafka_2.11-2.1.0.tgz'
  config:
    logdir: '/var/log/kafka'
    zookeeper:
      hosts:
          - node01:2181
          - node02:2181
          - node03:2181
    directory: /etc/kafka/conf
  running:
    enabled: True
    options:
      - name: kafka
      - enable: True
      - reload: True
```



#### 配置文件说明

- broker.id 默认取值为 grains['server_id'] 第8-9位
- listeners 默认监听地址为 Etho 网口地址

