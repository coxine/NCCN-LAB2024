#import "../template.typ": *

#let title = "Lab2 动态RIP"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-11-03"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 实验目的

1. 了解动态RIP路由协议
2. 掌握动态路由RIP的配置方法
3. 掌握使用动态RIP组网的方法

= 网络拓扑

#image("lab2.png")

= 实验内容

== 按照网络拓扑图配置各端口 ip, 并启动端口

=== RouterA
```
Router> enable # 进入特权模式
Router# configure terminal # 进入全局配置模式
Router(config)# hostname RouterA # 修改路由器名
RouterA(config)# interface s0/1/0 # 配置连接RouterB的端口
# 注：在Packet Tracer中，s0/1/0口对应的是Serial2/0
RouterA(config-if)# ip address 192.168.10.1 255.255.255.0
RouterA(config-if)# no shutdown
```

=== RouterB

```
Router> enable
Router# configure terminal
Router(config)# hostname RouterB
RouterB(config)# interface s0/1/0 # 配置连接RouterA的端口
RouterB(config-if)# ip address 192.168.10.2 255.255.255.0
RouterB(config-if)# no shutdown
RouterB(config-if)# exit
RouterB(config)# interface s0/1/1 # 配置连接RouterC的端口
# 注：在Packet Tracer中，s0/1/1口对应的是Serial3/0
RouterB(config-if)# ip address 192.168.20.2 255.255.255.0
RouterB(config-if)# no shutdown
```

=== RouterC

```
Router> enable
Router# configure terminal
Router(config)# hostname RouterC
RouterC(config)# interface s0/1/0 # 配置连接RouterB的端口
RouterC(config-if)# ip address 192.168.20.1 255.255.255.0
RouterC(config-if)# no shutdown
RouterC(config-if)# exit
```

== 检查连通性

=== 检查RouterA的路由表

注：以下命令与输出中的端口为Packet Tracer的版本。
```
RouterA#show ip route
Codes: C - connected, S - static, I - IGRP, R - RIP, M - mobile, B - BGP
       D - EIGRP, EX - EIGRP external, O - OSPF, IA - OSPF inter area
       N1 - OSPF NSSA external type 1, N2 - OSPF NSSA external type 2
       E1 - OSPF external type 1, E2 - OSPF external type 2, E - EGP
       i - IS-IS, L1 - IS-IS level-1, L2 - IS-IS level-2, ia - IS-IS inter area
       * - candidate default, U - per-user static route, o - ODR
       P - periodic downloaded static route

Gateway of last resort is not set

C    192.168.10.0/24 is directly connected, Serial2/0
```

=== 在RouterA上ping

```
RouterA#ping 192.168.10.2 # 成功

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 192.168.10.2, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 25/30/32 ms

RouterA#ping 192.168.20.2 # 失败

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 192.168.20.2, timeout is 2 seconds:
.....
Success rate is 0 percent (0/5)

RouterA#ping 192.168.20.1 # 失败

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 192.168.20.1, timeout is 2 seconds:
.....
Success rate is 0 percent (0/5)

```
== 配置 RIP 协议动态路由

=== RouterA
```
RouterA(config)#router rip
RouterA(config-router)#network 192.168.10.0
```
=== RouterB
```
RouterB(config)#router rip
RouterB(config-router)#network 192.168.10.0
RouterB(config-router)#network 192.168.20.0
```
=== RouterC
```
RouterC(config)#router rip
RouterC(config-router)#network 192.168.20.0
```

== 再次检查连通性

=== 再次检查RouterA的路由表

```
RouterA#show ip route
Codes: C - connected, S - static, I - IGRP, R - RIP, M - mobile, B - BGP
       D - EIGRP, EX - EIGRP external, O - OSPF, IA - OSPF inter area
       N1 - OSPF NSSA external type 1, N2 - OSPF NSSA external type 2
       E1 - OSPF external type 1, E2 - OSPF external type 2, E - EGP
       i - IS-IS, L1 - IS-IS level-1, L2 - IS-IS level-2, ia - IS-IS inter area
       * - candidate default, U - per-user static route, o - ODR
       P - periodic downloaded static route

Gateway of last resort is not set

C    192.168.10.0/24 is directly connected, Serial2/0
R    192.168.20.0/24 [120/1] via 192.168.10.2, 00:00:03, Serial2/0
```

此时增加了`R  192.168.20.0/24 [120/1] via 192.168.10.2, 00:00:03, Serial2/0`这个RIP连接。

=== 再次在RouterA上ping

```
RouteAr#ping 192.168.20.1

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 192.168.20.1, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 59/60/62 ms

```

此时，RouterA与RouterC可以ping通。


= 实验问题

#cprob()[在配置结束后用什么命令来查看具体的设置，请显示具体内容。
][
  使用show ip route，显示的内容中以"R"作为识别的即为RIP连接
  具体内容在第二次检查RouterA的路由表中有展现。
]

#cprob()[在路由器的全局模式下用`show ip protocol`检查当前时间参数设置，所显示的时间值分别代表什么？
][
  在RouterA上进行`show ip protocol`指令,显示结果如下
  ```
  RouterA#show ip protocol
  Routing Protocol is "rip"
  Sending updates every 30 seconds, next due in 18 seconds
  Invalid after 180 seconds, hold down 180, flushed after 240
  Outgoing update filter list for all interfaces is not set
  Incoming update filter list for all interfaces is not set
  Redistributing: rip
  Default version control: send version 1, receive any version
    Interface             Send  Recv  Triggered RIP  Key-chain
    Serial2/0             1     2 1
  Automatic network summarization is in effect
  Maximum path: 4
  Routing for Networks:
  	192.168.10.0
  Passive Interface(s):
  Routing Information Sources:
  	Gateway         Distance      Last Update
  	192.168.10.2         120      00:00:11
  Distance: (default is 120)
  ```

  - `Sending updates every 30 seconds`: 这表示路由器每30秒发送一次路由更新信息。这是RIP（路由信息协议）的默认更新间隔。

  - `next due in 18 seconds`: 这表示下一个路由更新将在18秒后发送。这是一个倒计时，显示了距离下次更新的剩余时间。

  - `Invalid after 180 seconds`: 这表示如果在180秒内没有收到某个路由的更新信息，该路由将被标记为无效。

  - `hold down 180`: 这表示在路由被标记为无效后，路由器将进入保持状态，持续180秒。在此期间，路由器不会接受任何关于该路由的更新信息，以防止路由环路。

  - `flushed after 240`: 这表示如果在240秒内仍未收到更新，该路由将被完全删除（flush）出路由表。
]

#cprob()[观察网络路由路径的选择
][
  对于RouterA来说,从`192.168.10.1`连接到`192.168.10.2`,然后通过RIP,连接到`192.168.20.2`,最后连接到`192.168.20.1`。
]

#cprob()[在路由器的全局模式下，`traceroute`命令可用来追踪数据包在网络上所经过的路由。可选择若干条有代表性的路径进行路由选择的跟踪，并将由源到目标
  的各路径的结果记录下来。
][
  (在RouterA上进行操作)
  ```
  Router#traceroute 192.168.20.1
  Type escape sequence to abort.
  Tracing the route to 192.168.20.1

    1   192.168.10.2    27 msec   31 msec   30 msec
    2   192.168.20.1    62 msec   48 msec   64 msec
  ```
]

= 实验收获

1. 巩固了路由端口的配置：
  - 温习了在上次实验中学习的对于路由端口的配置。
2. RIP动态路由配置：
  - 掌握了动态路由的配置方法，包括如何为每台路由器添加RIP的network配置。
  - 通过配置动态路由，成功实现了Router和RouterC之间的互联。