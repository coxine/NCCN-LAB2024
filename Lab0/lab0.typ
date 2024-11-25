#import "../template.typ": *

#let title = "基础操作速查"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-10-28"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 路由器

== 硬件接口

- 连接电脑显示终端内容：正面`Console`口，浅蓝色线连接
- 路由器间连接：背面`s0/1/0`口(左)，`s0/1/1`口（右）蓝色线连接
- 路由器与电脑连接：`g0/0/0`口

== 基本操作

```
Router> enable # 进入特权模式
Router# terminal length 0 # 设置终端显示不分页

Router# configure terminal # 进入全局配置模式
Router(config)# hostname \<name\> # 修改路由器名

# 进入控制台配置模式
Router(config)#line con 0
Router(config-line)#logging synchronous

# 关闭浪费时间的域名解析
Router(config)#no ip domain-lookup
```

== 去除密码

```
Router# enable # 进入特权模式
Router# configure terminal # 进入全局配置模式
Router(config)# no enable password # 去除特权密码
Router(config)# no enable secret # 去除特权密码
Router(config)# line con 0 # 进入控制台配置模式
Router(config-line)# no password # 去除控制台密码
Router(config-line)# no login # 去除控制台登录
Router(config-line)# exit # 退出控制台配置模式
Router(config)# line vty 0 4 # 进入虚拟终端配置模式
Router(config-line)# no password # 去除虚拟终端密码
Router(config-line)# no login # 去除虚拟终端登录
Router(config-line)# exit # 退出虚拟终端配置模式
Router(config)# exit # 退出全局配置模式
Router# write memory # 保存配置
```


== 配置IP

```
Router(config)# interface s0/1/0 # 进入接口配置模式
Router(config-if)# ip address \<ip\> \<mask\> # 配置接口IP地址
Router(config-if)# ip address \<ip\> \<mask\> secondary # 配置接口第二IP地址 (可配置多个)
Router(config-if)# no shutdown # 开启接口
Router(config-if)# exit # 退出接口配置模式
```

== 配置路由

```
# 静态路由
Router(config)# ip route \<dst\> \<mask\> \<next-hop\>
# 删除路由
Router(config)# no ip route \<dst\> \<mask\> \<next-hop\>
# 默认路由
Router(config)# ip route 0.0.0.0 0.0.0.0 \<next-hop\>
# 动态路由
Router(config)# router rip
Router(config-router)# network \<network\>
Router(config-router)# exit
```

== 环回接口

```
Router(config)# interface loopback 0 # 进入环回接口配置模式
Router(config-if)# ip address \<ip\> \<mask\> # 配置环回接口IP地址
Router(config-if)# no shutdown # 开启环回接口
Router(config-if)# exit # 退出环回接口配置模式
```

== OSPF

```
Router(config)# router ospf 1 # 进入OSPF配置模式
Router(config-router)# network \<network\> \<mask\> area \<area\> # 配置OSPF网络
Router(config-router)# exit # 退出OSPF配置模式
Router(config)# show ip ospf neighbor # 查看OSPF邻居
```

=== OSPF计时器

```
#定义 OSPF 路由器之间发送 "Hello" 数据包的时间间隔
Router(config-if)#ip ospf hello-interval 5

#定义 OSPF 路由器在多长时间内未接收到邻居的 Hello 包时，认为邻居不可达
RouterA(config-if)#ip ospf dead-interval 20
```

=== OSPF认证

```
#启用接口上的 MD5 认证密钥
Router(config-if)#ip ospf message-digest-key 1 md5 7 \<itsasecret\>

#启用区域的消息摘要认证
Router(config-router)#area 0 authentication message-digest

```

== NAT

```
#debug
Router#debug ip nat ha
```

== 显示情况

```
# 显示路由表
Router# show ip route

# 显示接口信息
Router# show ip protocols

# 显示OSPF信息
Router# show ip ospf

# 查看DR和BDR
Router# show ip ospf interface
```

= 交换机

- 在开启交换机时，需先用电脑连交换机Console口，输入`no`跳过默认配置，不然交换机无法启动。

= 故障Checklist

== 无法ping通

- 检查网线是否插好 指示灯是否亮
- 检查网关是否设置正确
- 路由器/交换机`show ip route`查看路由表
- `show ip interface brief`查看接口状态
- 求助助教