#import "../template.typ": *

#let title = "Lab7 PPP 验证实验 "
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-12-02"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 实验目的

1.学习使用PAP验证,使用常见正确与错误使用方法
1.学习使用PAP验证,使用常见正确与错误使用方法

= 网络拓扑

#image("lab7.png")

= 实验内容

== PAP验证

=== RouterA

```
Router> enable # 进入特权模式
Router# configure terminal # 进入全局配置模式
Router(config)# hostname RouterA # 修改路由器名
Router(config)# username nju password ccna
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
RouterB(config-if)# encapsulation ppp
RouterB(config-if)# no shutdown
RouterB(config-if)# ppp pap sent-username adsf password adsf
RouterB(config-if)# exit
RouterB(config)# exit
RouterB# ping 192.168.1.1
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 192.168.1.1, timeout is 2 seconds:
.....
Success rate is 0 percent (0/5)
# ping失败

RouterB# configure terminal
RouterB(config)# interface s0/1/0
RouterB(config-if)# ppp pap sent-username nju password ccna #设置正确的用户名和密码
RouterB(config-if)# end
RouterB# ping 192.168.1.1
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 192.168.1.1, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 28/28/32 ms
# ping 成功
```
== CHAP验证

=== RouterA

```
RouterA(config)#username nju2 password ccna
RouterA(config)#interface s0/1/0
RouterA(config-if)#ip address 192.168.1.1 255.255.255.0
RouterA(config-if)#encapsulation ppp
RouterA(config-if)#ppp authentication chap
RouterA(config-if)#no shutdown

```

=== RouterB

```
RouterB(config)#int s0/1/0
RouterB(config-if)#ip address 192.168.1.2 255.255.255.0
RouterB(config-if)#encapsulation ppp
RouterB(config-if)#ppp authentication chap
RouterB(config-if)#no shutdown
RouterB(config)#username nju1 password ccnp
RouterB#ping 192.168.1.1
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 192.168.1.1, timeout is 2 seconds:
.....
Success rate is 0 percent (0/5)
# ping失败
RouterB(config)#username nju1 password ccna #设置正确的用户名和密码
RouterB#ping 192.168.1.1
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 192.168.1.1, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 28/28/32 ms
# ping 成功
RouterB(config)#username RouterA password ccnp
RouterB#ping 192.168.1.1
```
== 在验证通过的情况下，将任意一边的口令随意设置成一个非ccna 的口令，再测试连通性

```
RouterB(config)#username RouterA password ccnp
RouterB#ping 192.168.1.1
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 192.168.1.1, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 28/28/32 ms
# ping 成功
```


= 实验收获

1. 学会启用PPP封装协议
2. 学会启用PAP身份验证,尝试正确与错误的验证方法
3. 学会设置被验证发送的用户名和口令
4. 了解学习CHAP认证协议,尝试正确与错误的认证协议