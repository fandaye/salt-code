# salt-code  consul
consul集群 自动化部署

测试环境：Centos 7 x86_64

引用pillar 参考:[pillar.example](https://github.com/fandaye/salt-code/blob/master/consul/pillar.example)

> {{ }} 是变量，请替换

token生成：
需要{{ acl_master_token }} 与 {{ acl_agent_token }}

生成命令：

    uuidgen


init.sls include: consul.install,consul.config,consul.service




说明：

- 先部署master节点： salt-call state.sls consul
- 同样部署agent节点：salt-call state.sls consul

如果启用了ACL控制，部署完成之后执行：

    curl --request PUT --header "X-Consul-Token:{{ acl_master_token }}" --data '{ "ID":"{{ acl_agent_token }}" ,"Name": "Agent Token","Type": "client", "Rules": "node \"\" { policy = \"write\" } service \"\" { policy = \"read\" }"}' http://127.0.0.1:8500/v1/acl/create
    curl --request PUT --header "X-Consul-Token:{{ acl_master_token }}" --data '{"ID": "anonymous", "Type": "client","Rules": "node \"\" { policy = \"read\" } service \"\" { policy = \"read\" }"}' http://127.0.0.1:8500/v1/acl/update
