# salt-code elasticsearch
elasticsearch 自动化部署

测试环境：Centos 7

引用pillar 参考:[pillar.example](https://github.com/fandaye/salt-code/blob/master/elasticsearch/pillar.example)

init.sls include:   
- elasticsearch.install  
- elasticsearch.config  
- elasticsearch.service

安装

    salt-call state.sls elasticsearch
