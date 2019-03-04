# salt-code  Etcd


为主机引用hosts，主要是为处理环境不一致导致获取IP问题

更改 etcd pillar 变量



安装`cfssl`

```
salt-call state.sls cfssl
```

安装`etcd`集群

```
salt-call state.sls etcd
```

1. 同步二进制包文件到服务器
2. 安装etcd
3. 同步证书：ca-config.json','ca.csr','ca-key.pem','ca.csr
4. 同步etcd证书配置
5. 创建etcd证书
6. 同步启动脚本
7. 启动服务

检查集群信息

```
for ip in 113 116 115; do \
etcdctl \
--endpoints=https://172.16.50.${ip}:2379 \
--ca-file=/etc/etcd/ssl/ca.pem  \
member list \
; done
```

输出结果：

```
... https://172.16.50.115:2380 clientURLs=https://172.16.50.115:2379 isLeader=false
... https://172.16.50.113:2380 clientURLs=https://172.16.50.113:2379 isLeader=false
... https://172.16.50.116:2380 clientURLs=https://172.16.50.116:2379 isLeader=true
```

