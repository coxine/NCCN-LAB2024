#import "../template.typ": *

#let title = "期末实验报告 2024"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-12-??"
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

- 掌握RIP路由协议的配置
- 深入了解交换机中VLAN配置
- 熟悉不同VLAN之间的路由配置
- 熟悉VLAN Trunk的配置
- 掌握静态NAT特征与配置
- 掌握ACL配置

= 使用技术

- VLAN路由连接
- RIP路由协议
- Trunk技术
- NAT技术
- ACL防火墙设置

#pagebreak()

= 网络拓扑

== 设备清单

- RIP：任意台数路由器
- VLAN Trunk：2台交换机 1台路由器 4台PC
- NAT：3台路由器
- ACL：2台路由器
- 总共：2台交换机、4台路由器、4台PC

= 路由表说明

= 连通性说明

= 实验步骤

== 配置PC

#table(
  columns: (10%, 30%, 30%, 30%),
  align: (center, center, center, center),
  table.header[*编号*][*IP*][*子网掩码*][*网关*],
  [PC1], [], [], [],
  [PC2], [], [], [],
  [PC3], [], [], [],
  [PC4], [], [], [],
)

== 配置路由器 RIP

=== Router1

```shell
```

=== Router2

```shell
```

=== Router3

```shell
```

=== Router4

```shell
```

== 验证RIP配置情况

== 配置交换机 VLAN

=== Switch1

```shell
```

=== Switch2

```shell
```

== 验证VLAN 配置情况

== 配置VLAN Trunk

=== Router1

```shell
```

=== Router2

```shell
```

== 验证VLAN Trunk 配置情况

== 配置NAT

== 验证NAT 配置情况

== 配置ACL

== 验证ACL 配置情况

== 关闭设备

= 实验总结