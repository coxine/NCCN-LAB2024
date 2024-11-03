#import "../template.typ": *

#let title = "Lab1 静态路由和简单组网"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-10-21"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 实验目的

1. 了解路由器的基本操作
2. 掌握静态路由的配置方法
3. 掌握简单组网的方法

= 网络拓扑

#image("lab1.png")

= 实验内容

== 配置服务器的端口

=== RouterA

```
Router> enable # 进入特权模式
Router# configure terminal # 进入全局配置模式
Router(config)# hostname RouterA # 修改路由器名
RouterA(config)# interface g0/0/0 # 配置连接PC1的端口
# 注：在Packet Tracer中，g0/0/0口对应的是FastEthernet0/0
RouterA(config-if)# ip address 192.168.10.1 255.255.255.0 # 配置端口IP地址
RouterA(config-if)# no shutdown # 开启端口
RouterA(config-if)# exit # 退出端口配置模式
RouterA(config)# interface s0/1/0 # 配置连接RouterB的端口
# 注：在Packet Tracer中，s0/1/0口对应的是Serial2/0
RouterA(config-if)# ip address 192.168.1.2 255.255.255.0
RouterA(config-if)# no shutdown
```

=== RouterB

```
Router> enable
Router# configure terminal
Router(config)# hostname RouterB
RouterB(config)# interface s0/1/0 # 配置连接RouterA的端口
RouterB(config-if)# ip address 192.168.1.1 255.255.255.0
RouterB(config-if)# no shutdown
RouterB(config-if)# exit
RouterB(config)# interface s0/1/1 # 配置连接RouterC的端口
# 注：在Packet Tracer中，s0/1/1口对应的是Serial3/0
RouterB(config-if)# ip address 192.168.2.1 255.255.255.0
RouterB(config-if)# no shutdown
```

=== RouterC

```
Router> enable
Router# configure terminal
Router(config)# hostname RouterC
RouterC(config)# interface s0/0/0 # 配置连接RouterB的端口
RouterC(config-if)# ip address 192.168.2.2 255.255.255.0
RouterC(config-if)# no shutdown
RouterC(config-if)# exit
RouterC(config)# interface g0/0/0 # 配置连接PC2的端口
RouterC(config-if)# ip address 192.168.20.1 255.255.255.0
RouterC(config-if)# no shutdown
```

== 配置路由表

=== RouterA

```
RouterA(config)# ip route 192.168.20.0 255.255.255.0 192.168.1.1
```

=== RouterB

```
RouterB(config)# ip route 192.168.20.0 255.255.255.0 192.168.2.2
RouterB(config)# ip route 192.168.10.0 255.255.255.0 192.168.1.2
```

=== RouterC

```
RouterC(config)# ip route 192.168.10.0 255.255.255.0 192.168.2.1
```

此时PC1和PC2可以互相ping通。


== 将静态路由改为默认路由

=== RouterA

```
RouterA(config)# no ip route 192.168.20.0 255.255.255.0 192.168.1.1
RouterA(config)# ip route 0.0.0.0 0.0.0.0 192.168.1.1
```

=== RouterC

```
RouterC(config)# no ip route 192.168.10.0 255.255.255.0 192.168.2.1
RouterC(config)# ip route 0.0.0.0 0.0.0.0 192.168.2.1
```

此时PC1和PC2可以互相ping通。

= 实验中遇到的问题及解决方法

== 某台电脑无法读取Console口的信息

经过我们更换连接线和端口，控制变量后发现疑似是路由器的Console口损坏，我们上报给老师，更换另一组机器进行实验。

== 路由器能ping通但电脑无法ping通

经过检查后，我们发现电脑上的IP网关设置错误，将网关设置为连接到路由器端口的对应地址即可ping通。

== Packet Tracer上的端口名与实际不符

在Packet Tracer中，端口名与实际设备上的端口名有所不同，如：

- 连接电脑的g0系列端口对应FastEthernet系列端口
- 连接路由器的s0系列端口对应Serial系列端口

== Packet Tracer 无法ping通

- 由于Packet Tracer虚拟硬件和实际硬件有所不同，需要在Packet Tracer内的Serial口单独设置Clock Rate。

= 拓展问题

#cprob()[假如只分配了一个网段：`192.168.10.0/24`，你该如何搭建上述拓扑？请设计并加以实现。
][
  1. 仿照先前的配置设备各个端口的IP地址：
    - PC1:
      - IP: `192.168.10.10`
      - 子网掩码: `255.255.255.0`
      - 网关: `192.168.10.1`
    - RouterA:
      - `g0/0/0`: `192.168.10.1`
      - `s0/1/0`: `192.168.10.2`
    - RouterB:
      - `s0/1/0`: `192.168.10.3`
      - `s0/1/1`: `192.168.10.4`
    - RouterC:
      - `s0/1/0`: `192.168.10.5`
      - `g0/0/0`: `192.168.10.6`
    - PC2:
      - IP: `192.168.10.20`
      - 子网掩码: `255.255.255.0`
      - 网关: `192.168.10.6`
  2. 配置路由表：
    - RouterA:
      - `ip route 192.168.10.20 255.255.255.255 192.168.10.3`
    - RouterB:
      - `ip route 192.168.10.20 255.255.255.255 192.168.10.5`
      - `ip route 192.168.10.10 255.255.255.255 192.168.10.2`
    - RouterC:
      - `ip route 192.168.10.10 255.255.255.255 192.168.10.4`
  3. 验证PC1和PC2可以互相ping通。
]

= 实验收获

1. 路由器基本操作：
  - 学会了如何进入路由器的特权模式和全局配置模式。
  - 通过具体命令配置了路由器的主机名、端口IP地址和开启端口。
2. 静态路由配置：
  - 掌握了静态路由的配置方法，包括如何为每台路由器添加路由条目。
  - 通过配置静态路由，成功实现了PC1和PC2之间的互联。
3. 默认路由的应用：
  - 学会了如何将静态路由改为默认路由，从而简化路由表的管理。
  - 验证了在更改为默认路由后，PC1和PC2仍然可以正常ping通，保证了网络的连通性。