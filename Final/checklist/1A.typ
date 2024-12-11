#import "../../template.typ": *

#let title = "期末实验 Checklist 1A"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-12-23"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= VLAN & Trunk - 6min

== 开机 准备网线 - 1min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [开启PC-A-Front], [],
  [开启PC-A-Mid], [],
  [开启PC-A-Back], [],
  [开启PC-B-Front], [],
  [开启PC-B-Mid], [],
)

== 连接设备 - 1min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接网线：Switch-A `g1/0/1` <==> PC-A-Front], [],
  [连接网线：Switch-A `g1/0/2` <==> PC-A-Mid], [],
)

== 初始化电脑 - 1min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Front超级终端打开并成功显示], [],
  [确认PC-A-FrontIP为`192.168.10.2`], [],
  [确认PC-A-Front子网掩码为`255.255.255.0`], [],
  [确认PC-A-Front网关为`192.168.10.1`], [],
)

== 输入命令 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-A-Mid配置Switch-A
    ```shell
    Switch(config)#hostname Switch-A
    Switch-A(config)vlan 10
    Switch-A(config)#vlan 20
    Switch-A(config)#interface g1/0/23
    Switch-A(config-if)#switchport mode trunk
    Switch-A(config)#interface g1/0/1
    Switch-A(config-if)#switchport mode access
    Switch-A(config-if)#switchport access vlan 10
    Switch-A(config-if)#interface g1/0/2
    Switch-A(config-if)#switchport mode access
    Switch-A(config-if)#switchport access vlan 20
    ```],
  [],
)

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Front能`ping`通`192.168.20.2`], [],
  [确认PC-A-Front能`ping`通`192.168.10.3`], [],
  [确认PC-A-Front能`ping`通`192.168.20.3`], [],
)

= RIP - 6min

== 接线 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接串口线：Router-A-Up `s0/1/0` <==> Router-A-Mid `s0/1/0`], [],
  [连接串口线：Router-A-Mid `s0/1/1` <==> Router-A-Down `s0/1/0`], [],
  [连接交叉线：Router-B-Up `g0/0/0` <==> PC-B-Mid], [],
)

== 输入命令 - 3min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-A-Mid配置Router-A-Mid
    ```shell
    Router(config)#hostname Router-A-Mid
    Router-A-Mid(config)#interface s0/1/0
    Router-A-Mid(config-if)#ip address 200.1.1.1 255.255.255.0
    Router-A-Mid(config-if)#no shutdown
    Router-A-Mid(config)#router rip
    Router-A-Mid(config-router)#network 192.168.10.0
    Router-A-Mid(config-router)#network 192.168.20.0
    Router-A-Mid(config-router)#network 200.1.1.0
    ```],
  [],
)

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认Router-A-Mid能`ping`通`200.2.1.2`], [],
  [确认Router-A-Mid能`ping`通`200.3.1.2`], [],
  [确认Router-A-Mid能`ping`通`200.4.1.2`], [],
  [确认PC-A-Mid能`ping`通`200.4.1.2`], [],
)

= NAT - 3min

= ACL - 3min

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认Router-A-Mid不能`ping`通`200.2.1.2`], [],
)
