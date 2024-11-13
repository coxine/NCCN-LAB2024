#import "../template.typ": *

#let title = "Lab5 NAT网络地址转换 "
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-11-11"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 实验目的

1. 学习配置和删除静态NAT
2. 学习指定内部和外部ip地址，以及配置PAT
3. 学习查看和清空NAT转换表

= 网络拓扑

#image("lab5.png")

= 实验内容

== 通过地址转换，从而使内部本地地址三种方式转换成外部全局地址进行访问

=== RouterA

```
Router> enable # 进入特权模式
Router# configure terminal # 进入全局配置模式
Router(config)# hostname RouterA # 修改路由器名
RouterA(config)# interface s0/1/0 # 配置以太网接口
# 注：在Packet Tracer中，s0/1/0口对应的是Serial2/0
RouterA(config-if)# ip address 192.168.1.2 255.255.255.0 # 配置端口IP地址
RouterA(config-if)# no shutdown # 开启端口
RouterA(config-if)# exit # 退出端口配置模式
```

=== RouterB

```
Router> enable
Router# configure terminal
Router(config)# hostname RouterB
RouterB(config)# interface s0/1/0 # 配置以太网接口
RouterB(config-if)# ip address 192.168.1.1 255.255.255.0
RouterB(config-if)# no shutdown
RouterB(config-if)# exit
RouterB(config)# interface s0/1/1 # 配置以太网接口
RouterB(config-if)# ip address 200.1.1.2 255.255.255.0
RouterB(config-if)# no shutdown
RouterB(config-if)# exit
```

=== RouterC

```
Router> enable
Router# configure terminal
Router(config)# hostname RouterC
RouterC(config)# interface s0/1/0 # 配置以太网接口
RouterC(config-if)# ip address 200.1.1.1 255.255.255.0
RouterC(config-if)# no shutdown
RouterC(config-if)# exit
```

== 配置静态NAT

=== RouterB

```
RouterB(config)#ip nat inside source static 192.168.1.1 200.1.1.254
RouterB(config)#interface s0/1/0
RouterB(config-if)#ip nat inside
RouterB(config-if)exit
RouterB(config)#interface s0/1/1
RouterB(config-if)#ip nat outside
RouterB(config-if)#exit
RouterB(config)#exit
RouterB#debug ip nat
IP NAT debugging is on
```

== 此时RouterA无法使用本地地址192.168.1.1 Ping 200.1.1.2

=== RouteA

```
RouterA#Ping 200.1.1.2

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 200.1.1.2, timeout is 2 seconds:
.....
Success rate is 0 percent (0/5)

```

== 为RouterA加上去往200.1.10网段的静态路由

=== RouteA

```
RouterA(config)#ip route 200.1.1.0 255.255.255.0 s2/0
RouterA#Ping 200.1.1.2

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 200.1.1.2, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 26/29/31 ms
```

=== RouterB

在Parket tracer中，此时RouterB并无具体的转换过程

==== 显示RouterB的NAT转换表

```
RouterB#show ip nat translations
Pro  Inside global     Inside local       Outside local      Outside global
---  200.1.1.254       192.168.1.1        ---                ---
```

== 删除RouterB的静态NAT条目，改为通过使用用户访问控制列表来定义本地地址池

=== RouterB

```
RouterB(config)#no ip nat inside source static 192.168.1.1 200.1.1.254
RouterB(config)#
ipnat_remove_static_cfg: id 1, flag A
RouterB(config)#access-list 1 permit 192.168.1.0 0.0.0.255
RouterB(config)#ip nat pool nju 200.1.1.253 200.1.1.254 netmask 255.255.255.0
RouterB(config)#ip nat inside source list 1 pool nju
ipnat_add_dynamic_cfg: id 1, flag 5, range 0
poolstart 200.1.1.253 poolend 200.1.1.254
RouterB(config)#id 1, flags 0, domain 0, lookup 0, aclnum 1 ,
        aclname 1 , mapname idb 0
```

=== 在RouterA上尝试ping RouterC

```
RouterA#ping 200.1.1.1

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 200.1.1.1, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 52/59/62 ms
```

=== 此时的RouterB

```
RouterB(config)#
NAT: s=192.168.1.2->200.1.1.253, d=200.1.1.1 [16]
NAT*: s=200.1.1.1, d=200.1.1.253->192.168.1.2 [1]
NAT: s=192.168.1.2->200.1.1.253, d=200.1.1.1 [17]
NAT*: s=200.1.1.1, d=200.1.1.253->192.168.1.2 [2]
NAT: s=192.168.1.2->200.1.1.253, d=200.1.1.1 [18]
NAT*: s=200.1.1.1, d=200.1.1.253->192.168.1.2 [3]
NAT: s=192.168.1.2->200.1.1.253, d=200.1.1.1 [19]
NAT*: s=200.1.1.1, d=200.1.1.253->192.168.1.2 [4]
NAT: s=192.168.1.2->200.1.1.253, d=200.1.1.1 [20]
NAT*: s=200.1.1.1, d=200.1.1.253->192.168.1.2 [5]
NAT: expiring 200.1.1.253 (192.168.1.2) icmp 16 (16)
NAT: expiring 200.1.1.253 (192.168.1.2) icmp 17 (17)
NAT: expiring 200.1.1.253 (192.168.1.2) icmp 18 (18)
NAT: expiring 200.1.1.253 (192.168.1.2) icmp 19 (19)
NAT: expiring 200.1.1.253 (192.168.1.2) icmp 20 (20)
```

== 模拟器不适配

后续的辅助地址相关操作以及PAT配置操作由于Parket tracer模拟器不支持:
- `-ip address IP MASK secondary`的`secondary`参数
- `-ip nat pool nju IP1 IP2 prefix-length 24` 的`prefix-length`参数
所以未成功在模拟器中实现，也因此无法展示终端信息。


= 实验收获

1. 学会了配置和删除静态NAT的相关基本操作
2. 学会了指定内部和外部ip地址的相关基本操作
3. 学会了设置辅助地址以及使用辅助地址的相关基本操作
4. 学会了配置PAT的相关基本操作
5. 学会了查看和清空NAT转换表的相关基本操作