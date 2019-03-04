etcd:
  cluster:
    - node02=https://172.16.50.113:2380
    - node03=https://172.16.50.115:2380
    - node04=https://172.16.50.116:2380
  ca_dir: /etc/etcd/ssl
  bin_dir: /usr/bin
  version: 3.3.11
