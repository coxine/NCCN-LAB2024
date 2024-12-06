#import "../template.typ": *

#let title = "Lab6 ACL 实验 "
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-12-02"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 实验目的

1.学习使用标准ACL和拓展ACL,并对两种ACL进行比较

= 网络拓扑

#image("lab6.png")

= 实验内容

== 搭建网络拓扑，保证三层连通性

=== RouterA

```
Router> enable # 进入特权模式
Router# configure terminal # 进入全局配置模式
Router(config)# hostname RouterA # 修改路由器名
RouterA(config)# interface s0/1/0 # 配置以太网接口
# 注：在Packet Tracer中，s0/1/0口对应的是Serial2/0
RouterA(config-if)# ip address 192.168.1.1 255.255.255.0 # 配置端口IP地址
RouterA(config-if)# no shutdown # 开启端口
RouterA(config-if)# exit # 退出端口配置模式
```

=== RouterB

```
Router> enable
Router# configure terminal
Router(config)# hostname RouterB
RouterB(config)# interface s0/1/0 # 配置以太网接口
# 注：在Packet Tracer中，s0/1/0口对应的是Serial2/0
RouterB(config-if)# ip address 192.168.1.2 255.255.255.0
RouterB(config-if)# no shutdown
RouterB(config-if)# exit
```
== 使用扩展的ACL封杀RouterA到RouterB的PING命令

=== RouterB

```
RouterB#ping 192.168.1.1

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 192.168.1.1, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 30/31/33 ms
```

=== RouterA

```
# 创建ACL

RouterA(config)#access-list 100 deny icmp 192.168.1.1 0.0.0.0 192.168.1.2 0.0.0.0
RouterA(config)#access-list 100 permit ip any any
RouterA(config)#exit
RouterA#show ip access-lists
Extended IP access list 100
    deny icmp host 192.168.1.1 host 192.168.1.2
    permit ip any any

# 应用ACL到接口

RouterA(config)#interface serial 3/0
RouterA(config-if)#ip access-group 100 out
RouterA(config-if)#exit
RouterA(config)#interface serial 2/0
RouterA(config-if)#ip access-group 100 out
RouterA(config-if)#exit
RouterA(config)#exit

RouterA#ping 192.168.1.2

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 192.168.1.2, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 26/29/32 ms

# 配置的ACL没有生效

RouterA#show ip access-lists
Extended IP access list 100
    deny icmp host 192.168.1.1 host 192.168.1.2
    permit ip any any
```

=== RouterB

```
RouterB(config)#access-l 100 deny icmp host 192.168.1.1 host 192.168.1.2
RouterB(config)#access-l 100 permit icmp any any
RouterB(config)#interface serial 2/0
RouterB(config-if)#ip access-group 100 in
```

=== RouterA

```
RouterA#ping 192.168.1.2

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 192.168.1.2, timeout is 2 seconds:
.....
Success rate is 0 percent (0/5)

# 实验成功，ICMP包被拒绝
```

== 使用ACL禁止RouterA到RouterB的TELNET应用

=== 方法一：使用扩展ACL

==== RouterB

```
#清除先前的配置

RouterB(config)#interface serial 2/0
RouterB(config-if)#no ip access-group 100 in
```

==== RouterB

```
RouterB(config)#enable secret nju
RouterB(config)#line vty 0 4
RouterB(config-line)#password cisco
RouterB(config-line)#login
```

==== RouterA

```
RouterA#ping 192.168.1.2

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 192.168.1.2, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 18/28/31 ms

RouterA#telnet 192.168.1.2
Trying 192.168.1.2 ...Open


User Access Verification

Password:
RouterB> # 在此处从RouterA上通过telnet连接到了RouterB的控制台
```

==== RouterB

```
RouterB(config)#access-list 101 deny tcp host 192.168.1.1 any eq 23
RouterB(config)#access-list 101 permit ip any any
RouterB(config)#interface serial 2/0
RouterB(config-if)#ip access-group 101 in
```

==== RouterA

```
RouterA#telnet 192.168.1.2
Trying 192.168.1.2 ...
% Connection timed out; remote host not responding
RouterA#ping 192.168.1.2

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 192.168.1.2, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 21/29/32 ms

# telnet被拒绝但ping成功
```

=== 方法二：使用标准ACL

==== RouterB

```
# 清除先前的配置

RouterB(config)#interface serial 2/0
RouterB(config-if)#no ip access-group 101 in
```

==== RouterB

```
RouterB(config)#access-list 1 deny host 192.168.1.1
RouterB(config)#access-list 1 permit any
RouterB(config)#line vty 0 4
RouterB(config-line)#access-class 1 in
```

==== RouterA

```
RouterA#telnet 192.168.1.2
Trying 192.168.1.2 ...
% Connection refused by remote host

# 成功拒绝telnet
```

= 实验收获

1. 学会设置并应用ACL
2. 学会使用扩展ACL和标准ACl分别禁用路由到路由之间的TELENT应用
3. 了解了扩展ACl和标准ACl之间的区别，以及在实际使用中最好使用扩展ACL的意义