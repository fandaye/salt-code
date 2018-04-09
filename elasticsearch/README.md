# salt-code elasticsearch
elasticsearch 自动化部署

测试环境：Centos 7

引用pillar 参考:[pillar.example](https://github.com/fandaye/salt-code/blob/master/elasticsearch/pillar.example)

init.sls include:   
- elasticsearch.install  
- elasticsearch.config  
- elasticsearch.service

目录说明:

- files/etc/nginx/certs  ssl证书目录
- files/etc/nginx/sites  虚拟主机目录，参考 [a.com](https://github.com/fandaye/salt-code/blob/master/nginx/files/etc/nginx/sites/a.com.conf)  

安装

    salt-call state.sls elasticsearch
