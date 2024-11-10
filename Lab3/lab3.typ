#import "../template.typ": *

#let title = "Lab3 配置单域OSPF "
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-11-09"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 实验目的

1. 学习环回接口用途并且正确配置
2. 练习`show`命令基本操作并且正确读取所需信息
3. 配置OSPF并查看运行情况，学会OSPF基本操作如设置计时器，认证

= 网络拓扑

#image("lab3.png")

= 实验内容

== 根据网络拓扑图进行组建和配置网络

=== RouterA

```
Router> enable # 进入特权模式
Router# configure terminal # 进入全局配置模式
Router(config)# hostname RouterA # 修改路由器名
RouterA(config)# interface g0/0/0 # 配置以太网接口
# 注：在Packet Tracer中，g0/0/0口对应的是FastEthernet0/0
RouterA(config-if)# ip address 192.168.1.1 255.255.255.0 # 配置端口IP地址
RouterA(config-if)# no shutdown # 开启端口
RouterA(config-if)# exit # 退出端口配置模式
```

=== RouterB

```
Router> enable
Router# configure terminal
Router(config)# hostname RouterB
RouterB(config)# interface g0/0/0 # 配置以太网接口
RouterB(config-if)# ip address 192.168.1.2 255.255.255.0
RouterB(config-if)# no shutdown
RouterB(config-if)# exit
```

=== RouterC

```
Router> enable
Router# configure terminal
Router(config)# hostname RouterC
RouterC(config)# interface g0/0/0 # 配置以太网接口
RouterC(config-if)# ip address 192.168.1.3 255.255.255.0
RouterC(config-if)# no shutdown
RouterC(config-if)# exit
```

=== RouterA

```
RouterA(config)#exit
RouterA#ping 192.168.1.2 # 检测以太网接口连通性
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 192.168.1.2, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 34/56/63 ms
# A,B可以ping通
```

== 配置环回接口

=== RouterA

```
RouterA#config terminal
RouterA(config)#int lo0
RouterA(config-if)#ip address 10.0.0.1 255.255.255.255
```

=== RouterB

```
RouterB(config)#int lo0
RouterB(config-if)#ip address 10.0.0.2 255.255.255.255
```

=== RouterC

```
RouterC(config)#int lo0
RouterC(config-if)#ip address 10.0.0.3 255.255.255.255
```

== 配置OSPF

=== RouteA
```
RouterA(config)#router ospf 1
RouterA(config-router)#network 192.168.1.0 0.0.0.255 area 0
```

=== RouterB

```
RouterB(config)#router ospf 1
RouterB(config-router)#network 192.168.1.0 0.0.0.255 area 0
```

=== RouterC

```
RouterC(config)#router ospf 1
RouterC(config-router)#network 192.168.1.0 0.0.0.255 area 0
```

== 用 `show` 命令检查运行情况

=== RouterB

```
RouterB(config-router)# exit
RouterB(config)#exit
RouterB#show ip protocols

Routing Protocol is "ospf 1"
  Outgoing update filter list for all interfaces is not set
  Incoming update filter list for all interfaces is not set
  Router ID 10.0.0.2
  Number of areas in this router is 1. 1 normal 0 stub 0 nssa
  Maximum path: 4
  Routing for Networks:
    192.168.1.0 0.0.0.255 area 0
  Routing Information Sources:
    Gateway         Distance      Last Update
    192.168.1.1          110      00:01:03
    192.168.1.3          110      00:01:06
  Distance: (default is 110)


RouterB#show ip ospf #获得有关OSPF进程的消息信息

Routing Process "ospf 1" with ID 10.0.0.2
 Supports only single TOS(TOS0) routes
 Supports opaque LSA
 SPF schedule delay 5 secs, Hold time between two SPFs 10 secs
 Minimum LSA interval 5 secs. Minimum LSA arrival 1 secs
 Number of external LSA 0. Checksum Sum 0x000000
 Number of opaque AS LSA 0. Checksum Sum 0x000000
 Number of DCbitless external and opaque AS LSA 0
 Number of DoNotAge external and opaque AS LSA 0
 Number of areas in this router is 1. 1 normal 0 stub 0 nssa
 External flood list length 0
    Area BACKBONE(0)
        Number of interfaces in this area is 1
        Area has no authentication
        SPF algorithm executed 2 times
        Area ranges are
        Number of LSA 4. Checksum Sum 0x034862
        Number of opaque link LSA 0. Checksum Sum 0x000000
        Number of DCbitless LSA 0
        Number of indication LSA 0
        Number of DoNotAge LSA 0
        Flood list length 0

RouterB#show ip ospf interface#查看DR/BDR

FastEthernet0/0 is up, line protocol is up
  Internet address is 192.168.1.2/24, Area 0
  Process ID 1, Router ID 10.0.0.2, Network Type BROADCAST, Cost: 1
  Transmit Delay is 1 sec, State BDR, Priority 1
  Designated Router (ID) 10.0.0.3, Interface address 192.168.1.3 #DR为RouterC
  Backup Designated Router (ID) 10.0.0.2, Interface address 192.168.1.2 #BDR为RouterB
  Timer intervals configured, Hello 10, Dead 40, Wait 40, Retransmit 5
    Hello due in 00:00:04
  Index 1/1, flood queue length 0
  Next 0x0(0)/0x0(0)
  Last flood scan length is 1, maximum is 1
  Last flood scan time is 0 msec, maximum is 0 msec
  Neighbor Count is 2, Adjacent neighbor count is 2
    Adjacent with neighbor 10.0.0.1
    Adjacent with neighbor 10.0.0.3  (Designated Router)
  Suppress hello for 0 neighbor(s)
```

== 调节OSPF的计时器

=== RouteA

```
RouteA(config-router)#exit
RouterA(config)#interface g0/0/0
RouterA(config-if)#ip ospf hello-interval 5 #定义 OSPF 路由器之间发送 "Hello" 数据包的时间间隔
RouterA(config-if)#ip ospf dead-interval 20 #定义 OSPF 路由器在多长时间内未接收到邻居的 Hello 包时，认为邻居不可达
```

== 设置OSPF认证

```
RouterA(config-if)#ip ospf message-digest-key 1 md5 7 itsasecret  #启用接口上的 MD5 认证密钥
RouterA(config-if)#router ospf 1
RouterA(config-router)#area 0 authentication message-digest #启用区域的消息摘要认证
```

= 实验中遇到的问题及解决方法

== 三台机器配置好了以太网接口无法ping通

经过很多尝试之后通过观察别人组和求助助教，发现是我们交换机没有成功启动，需连接PC在命令行界面中完成初始化后方可使用。

= 拓展问题

#cprob()[哪个路由器成为了DR？哪个路由器成为了BDR？为什么？
][
  RouterC成为了DR,RouterB成为了BDR
  OSPF 的 DR 和 BDR 选举主要基于以下两个因素：
  1.OSPF 优先级（OSPF Priority）
  2.Router ID
  当多个路由器在一个广播网络中时，OSPF 优先级高的路由器会被优先选为 DR。如果 OSPF 优先级相同，那么 Router ID 更高的路由器将会成为 DR。
  RouterC 的 Router ID 是 10.0.0.3
  RouterB 的 Router ID 是 10.0.0.2
  RouterA 的 Router ID 是 10.0.0.1
  在这种情况下，Router ID 最高的路由器会被选为 DR，而次高的路由器会成为 BDR。因此，RouterC 成为了 DR，RouterB 成为了 BDR。
]

= 实验收获

1. 学会OSPF相关基本操作
  - 学会了配置环回接口。
  - 学会了配置OSPF。
2. 学会基本`show`命令
  - 学会使用`show`命令并且从输出信息中读取所需信息，例如DR、BDR等。
3. 了解OSPF计时器，认证
  - 学会调节OSPF计时器。
  - 学会设置OSPF认证并且初步了解其中原理。