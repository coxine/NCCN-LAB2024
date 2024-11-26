#import "../template.typ": *

#let title = "Lab4 VALN间路由 "
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-11-25"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 实验目的

1. 学习`Vlan`的划分。
2. 学习`VTP`同步。
3. 学习将接口划分进`Vlan`。
4. 学习`Trunk`链路的封装类型。
5. 学习子接口的配置。

= 网络拓扑

#image("lab4.png")

上图中：`PC0`和`PC2`属于`Vlan 10`， `PC1`和`PC3`属于`Vlan 20`

= 实验内容

== 根据网络拓扑图连接好设备
#table(
  align: center,
  columns: 5,
  rows: 4,
  [], [PC0], [PC1], [PC2], [PC3],
  [IP地址], [192.168.10.2], [192.168.20.2], [192.168.10.3], [192.168.20.3],
  [子网掩码], [255.255.255.0], [255.255.255.0], [255.255.255.0], [255.255.255.0],
  [默认网关], [192.168.10.1], [192.168.20.1], [192.168.10.1], [192.168.20.1],
)

== 将`Switch1`和`Switch2`之间的链路设置为`Trunk`链路
使用`g1/0/24`接口作为连接两个Switch的接口

=== `Switch1`

```
Switch1(config)# interface g1/0/24
Switch1(config-if)# switchport mode trunk
```
=== `Switch2`

```
Switch2(config)# interface g1/0/24
Switch2(config-if)# switchport mode trunk
```

== 划分两个`Vlan`，将对应的PC划分到对应`Vlan`

=== 划分两个`Vlan`
```
Switch1(config)# vlan 10
Switch2(config)# vlan 20
```

=== 划分`Switch1`下的PC
`PC0`，`PC1`分别使用Switch1的 `g1/0/1`，`g1/0/2`


```
Switch1(config)# int g1/0/1
Switch1(config-if)# switchport mode access
Switch1(config-if)# switchport access vlan 10

Switch1(config)# int g1/0/2
switch1(config-if)# switchport mode access
Switch1(config-if)# switchport access vlan 20
```


=== 划分`Switch2`下的PC

`PC2`，`PC3`分别使用Switch2的 `g1/0/1`，`g1/0/2`

```
Switch2(config)# int g1/0/1
Switch2(config-if)# switchport mode access
Switch2(config-if)# switchport access vlan 10

Switch2(config)# int g1/0/2
switch2(config-if)# switchport mode access
Switch2(config-if)# switchport access vlan 20
```

== `Vlan`测试

`Vlan 10` 下 `PC0`和`PC2`可以相互`ping`通

`Vlan 20` 下 `PC1`和`PC3`可以相互`ping`通

但是，跨`Vlan`不能访问

== 配置`Router`为`Vlan10` 和`Vlan20` 的网关

使用`Switch1` 的`g1/0/23`接口连接`Router`的`g0/0/0`接口

=== 将`Switch1` 与 `Router`连接的接口设置为`Trunk`接口

```
Switch1(config)# int g1/0/23
Switch1(config-if)# switchport mode trunk
```

=== `Router`划分两个子接口，分别作为`Vlan10`和`Vlan20`的网关
```
Router(config)# int g0/0/0
Router(config-if)# no ip address
Router(config-if)# no shutdown

Router(config)# int g0/0/0.10
Router(config-if)# encapsulation dot1q 10
Router(config-if)# ip address 192.168.10.1 255.255.255.0

Router(config)# int g0/0/0.20
Router(config-if)# encapsulation dot1q 20
Router(config-if)# ip address 192.168.20.1 255.255.255.0
```

== 测试`Router`的网关
`PC0` 与 `PC1` 可以相互访问，实际上任意两台PC都可以相互访问。

= 实验中遇到的问题及解决方法

== `Vlan`测试通过，但是`Router`的网关测试不通过
`Switch`的接口是纵向排布，但是我们以为是横向排布。导致`PC`一直分别接在`g1/0/1`和`g1/0/3`，但是配置`Vlan`的时候以为是`g1/0/1`和`g1/0/2`，导致`Vlan 20`从来就是不存在的，所以能通过`Vlan`的隔离测试，但是不能通过网关测试。正确调整接口位置便解决。感谢火眼金睛的助教老师！！

= 实验收获

1. 学会了`Vlan`划分的基本操作。
2. 了解了`VTP`同步。
3. 学会了将接口划分进`Vlan`的基本操作。
4. 了解了`Trunk`链路的封装类型。
5. 学会了子接口的配置的操作。
