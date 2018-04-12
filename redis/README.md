# salt-code  redis
 redis 自动化部署

测试环境：Centos 7

引用pillar 参考:[pillar.example](https://github.com/fandaye/salt-code/blob/master/redis/pillar.example)

init.sls include: 

- redis.install
- redis.config
- redis.service

安装

    salt-call state.sls redis
    
卸载

    salt-call state.sls redis.uninstall
