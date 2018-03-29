# salt-code  php
php 自动化部署

测试环境：Centos 6/7

引用pillar 参考:[pillar.example](https://github.com/fandaye/salt-code/blob/master/php/pillar.example)

init.sls include: php.install,php.config,php.service

安装

    salt-call state.sls php
    
卸载

    salt-call state.sls php.uninstall
