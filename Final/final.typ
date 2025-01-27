#import "../template.typ": *

#let title = "期末实验报告 2024"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-12-23"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 实验要求

== 基本要求

1. 拓扑需使用动态路由协议。
2. 拓扑中需包含VLAN及trunk技术。
3. 拓扑至少需包含设备：2台交换机、4台路由器、4台PC。
4. 每组时间为60分钟。
5. 上机报告需包含拓扑说明. 相关路由表信息. 连通性说明。提交时现场助教或老师将在现场确认。
6. 完成规定的基本要求为90分。
7. 拓扑中设计较为复杂的网络技术（如ACL，NAT等）等将有加分。

== 补充说明

1. 现场交报告检查。上机考试中助教或老师会现场抽查考生关于其所在组拓扑相关的问题，若表现差会降低该组总分。
2. 每组结束后需要清除设备配置保证设备正常交由助教确认后方可离开。
3. 30分钟内完成实验并提交也有加分。
4. 每个加分点为5分，多个加分点可以累加，但是总分上限为100分。

= 实验目的

- 深入了解交换机中VLAN配置
- 熟悉不同VLAN之间的路由配置
- 熟悉VLAN Trunk的配置
- 掌握RIP路由协议的配置
- 掌握静态NAT特征与配置
- 掌握ACL配置

= 使用技术

- VLAN路由连接
- Trunk技术
- RIP路由协议
- NAT技术
- ACL防火墙设置

#pagebreak()

= 网络拓扑

#image("./Final.png")

= 实验步骤

== 配置PC的 IP 地址

#table(
  columns: (25%, 25%, 25%, 25%),
  align: (center, center, center, center),
  table.header[*设备*][*IP*][*子网掩码*][*网关*],
  [VLAN10PC1], [192.168.10.2], [255.255.255.0], [192.168.10.1],
  [VLAN20PC1], [192.168.20.2], [255.255.255.0], [192.168.20.1],
  [VLAN10PC2], [192.168.10.3], [255.255.255.0], [192.168.10.1],
  [VLAN20PC2], [192.168.20.3], [255.255.255.0], [192.168.20.1],
  [PC4], [200.3.1.2], [255.255.255.0], [200.3.1.1],
)

== 配置交换机 VLAN并验证

=== Switch1

```shell
Switch1(config)#vlan 10
Switch1(config)#vlan 20
Switch1(config)#interface g1/0/23
Switch1(config-if)#switchport mode trunk
Switch1(config)#interface g1/0/1
Switch1(config-if)#switchport mode access
Switch1(config-if)#switchport access vlan 10
Switch1(config-if)#interface g1/0/2
Switch1(config-if)#switchport mode access
Switch1(config-if)#switchport access vlan 20
```

=== Switch2

```shell
Switch2(config)#vlan 10
Switch2(config)#vlan 20
Switch2(config)#interface g1/0/23
Switch2(config-if)#switchport mode trunk
Switch2(config)#interface g1/0/1
Switch2(config-if)#switchport mode access
Switch2(config-if)#switchport access vlan 10
Switch2(config-if)#interface g1/0/2
Switch2(config-if)#switchport mode access
Switch2(config-if)#switchport access vlan 20
```
=== 验证VLAN 配置情况

- VLAN10PC1、VLAN10PC2可`ping`通。
- VLAN20PC1、VLAN20PC2可`ping`通。
- 分属VLAN10和VLAN20的PC不可`ping`通。

== 配置VLAN Trunk 并验证

=== Switch1

```shell
Switch1(config)#interface g1/0/24
Switch1(config-if)#switchport mode trunk
```

=== VlanController

```shell
VlanController(config)#interface g0/0/0
VlanController(config-if)#no ip address
VlanController(config-if)#no shutdown
VlanController(config)#int g0/0/0.10
VlanController(config-if)#encapsulation dot1q 10
VlanController(config-if)#ip address 192.168.10.1 255.255.255.0
VlanController(config)#int g0/0/0.20
VlanController(config-if)#encapsulation dot1q 20
VlanController(config-if)#ip address 192.168.20.1 255.255.255.0
```

=== 验证VLAN 连通情况

- VLAN10PC1、VLAN10PC2、VLAN20PC1、VLAN20PC2均可`ping`通。


== 配置路由器 RIP 并验证

=== VlanController

```shell
VlanController(config)#interface s0/1/0
VlanController(config-if)#ip address 200.1.1.1 255.255.255.0
VlanController(config-if)#no shutdown
VlanController(config)#router rip
VlanController(config-router)#network 192.168.10.0
VlanController(config-router)#network 192.168.20.0
VlanController(config-router)#network 200.1.1.0
```

=== TransRouter

```shell
TransRouter(config)#interface s0/1/0
TransRouter(config-if)#ip address 200.1.1.2 255.255.255.0
TransRouter(config-if)#no shutdown
TransRouter(config)#interface s0/1/1
TransRouter(config-if)#ip address 200.2.1.1 255.255.255.0
TransRouter(config-if)#no shutdown
TransRouter(config)#router rip
TransRouter(config-router)#network 200.1.1.0
TransRouter(config-router)#network 200.2.1.0
```

=== FinalRouter

```shell
FinalRouter(config)#interface s0/1/0
FinalRouter(config-if)#ip address 200.2.1.2 255.255.255.0
FinalRouter(config-if)#no shutdown
FinalRouter(config)#interface s0/1/1
FinalRouter(config-if)#ip address 114.5.14.2 255.255.255.0
FinalRouter(config-if)#no shutdown
FinalRouter(config)#interface g0/0/0
FinalRouter(config-if)#ip address 200.3.1.1 255.255.255.0
FinalRouter(config-if)#no shutdown
FinalRouter(config)#router rip
FinalRouter(config-router)#network 200.2.1.0
FinalRouter(config-router)#network 200.3.1.0
```

=== OutsideRouter

```shell
OutsideRouter(config)#interface s0/1/0
OutsideRouter(config-if)#ip address 114.5.114.1
OutsideRouter(config-if)#no shutdown
```

=== 验证RIP配置情况

- 除了OutsideRouter以外的各台设备均可`ping`通。
- 此处取最长链路，VLAN20PC1 `ping`PC4来验证联通性。

== 配置NAT并验证

=== FinalRouter

```shell
FinalRouter(config)#ip nat inside source static 200.2.1.1 114.5.14.254
FinalRouter(config)#ip nat inside source static 200.3.1.2 114.5.14.253
FinalRouter(config)#interface s0/1/0
FinalRouter(config-if)#ip nat inside
FinalRouter(config)#interface s0/1/1
FinalRouter(config-if)#ip nat outside
FinalRouter(config-if)#exit
FinalRouter#debug ip nat
```

=== TransRouter

在TransRouter上增加对应的路由表项:

```shell
TransRouter(config)#ip route 114.5.14.0 255.255.255.0 s0/1/1
```

=== 验证 NAT 配置情况

- TransRouter可以`ping`通OutsideRouter`114.5.14.1`。
- OutsideRouter可以`ping`通TransRouter的NAT地址`114.5.14.254`。
- OutsideRouter可以`ping`通PC4的NAT地址`114.5.14.253`。

== 配置ACL并验证

=== FinalRouter

```shell
FinalRouter(config)#access-list 100 deny icmp host 200.2.1.1 host 200.2.1.2
FinalRouter(config)#access-list 100 permit ip any any
FinalRouter(config)#interface s0/1/0
FinalRouter(config-if)#ip access-group 100 in
```

=== 验证ACL 配置情况

- TransRouter不可以`ping`通FinalRouter`200.2.1.2`。但是可以`ping`通除此之外的所有设备。
- 其余设备不受影响。


= 实验总结

本次实验通过配置网络拓扑，深入了解了VLAN、Trunk、RIP路由协议、NAT技术和ACL防火墙等关键网络技术。通过以下几个方面的配置和验证，达成了实验的目标：

1. VLAN与Trunk技术：通过配置交换机的VLAN与Trunk端口，实现了不同VLAN之间的隔离与数据传输，同时也通过配置VLAN Trunk使得多台交换机之间能够正确传输VLAN数据，保证了网络拓扑的合理性和稳定性。
2. RIP路由协议：通过配置RIP协议在路由器之间的路由信息传播，实现了不同网络之间的互联互通。验证过程中，除OutsideRouter外的各台设备之间的联通性正常，确保了路由协议配置的成功。
3. NAT技术：通过配置静态NAT，将内部网络地址映射到公网地址，使得内网设备能够通过外网进行通信。通过验证NAT配置，确保了外部网络能够访问内部网络，保证了网络的正常访问。
4. ACL配置：通过配置访问控制列表（ACL），成功阻止了TransRouter访问FinalRouter，增强了网络安全性。其他设备的网络访问不受影响，验证了ACL的有效性。
5. 设备配置与故障排查：在实验过程中，通过不断验证和排查，确保了设备配置的正确性和网络的正常连通性。

通过本次实验，增强了我们对网络设备配置的理解和操作能力，也提升了对复杂网络问题的排查与解决能力，是对我们一学期以来计算机网络知识的成功总结和检验。
