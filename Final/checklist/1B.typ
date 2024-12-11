#import "../../template.typ": *

#let title = "期末实验 Checklist 1B"
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
  [准备5根Console线], [],
  [将5根Console线分成2+3], [],
)

== 连接设备 - 1min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接网线：Switch-B `g1/0/1` <==> PC-A-Back], [],
  [连接网线：Switch-B `g1/0/2` <==> PC-B-Front], [],
)

== 初始化电脑 - 1min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Back超级终端打开并成功显示], [],
  [确认PC-A-BackIP为`192.168.10.3`], [],
  [确认PC-A-Back`子网掩码为255.255.255.0`], [],
  [确认PC-A-Back网关为`192.168.10.1`], [],
)

== 输入命令 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-B-Mid配置SwitchB
    ```shell
    Switch(config)#hostname Switch-B
    Switch-B(config)#vlan 10
    Switch-B(config)#vlan 20
    Switch-B(config)#interface g1/0/23
    Switch-B(config-if)#switchport mode trunk
    Switch-B(config)#interface g1/0/1
    Switch-B(config-if)#switchport mode access
    Switch-B(config-if)#switchport access vlan 10
    Switch-B(config-if)#interface g1/0/2
    Switch-B(config-if)#switchport mode access
    Switch-B(config-if)#switchport access vlan 20
    Switch-B(config)#interface g1/0/24
    Switch-B(config-if)#switchport mode trunk
    ```],
  [],
)

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Back能`ping`通`192.168.20.2`], [],
  [确认PC-A-Back能`ping`通`192.168.10.2`], [],
  [确认PC-A-Back能`ping`通`192.168.20.3`], [],
)

= RIP - 6min

== 接线 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接串口线：Router-A-Down `s0/1/1` <==> Router-B-Up `s0/1/0`], [],
  [连接串口线：Router-B-Up `s0/1/1` <==> Router-B-Mid `s0/1/0`], [],
  [连接网线：Router-B-Up `g0/0/0` <==> PC-B-Mid], [],
)

== 输入命令 - 3min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-B-Front配置Router-B-Up
    ```shell
    Router(config)#hostname Router-B-Up
    Router-B-Up(config)#interface s0/1/0
    Router-B-Up(config-if)#ip address 200.3.1.2 255.255.255.0
    Router-B-Up(config-if)#no shutdown
    Router-B-Up(config)#interface s0/1/1
    Router-B-Up(config-if)#ip address 114.5.14.2 255.255.255.0
    Router-B-Up(config-if)#no shutdown
    Router-B-Up(config)#interface g0/0/0
    Router-B-Up(config-if)#ip address 200.4.1.1 255.255.255.0
    Router-B-Up(config-if)#no shutdown
    Router-B-Up(config)#router rip
    Router-B-Up(config-router)#network 200.3.1.0
    Router-B-Up(config-router)#network 200.4.1.0
    ```
  ],
  [],
)

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认Router-B-Up能`ping`通`200.2.1.2`], [],
  [确认Router-B-Up能`ping`通`200.3.1.2`], [],
  [确认Router-B-Up能`ping`通`200.1.1.2`], [],
  [确认PC-B-Front能`ping`通`200.4.1.2`], [],
)

= NAT - 3min

== 输命令 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-B-Front配置Router-B-Up
    ```shell
    Router-B-Up(config)#ip nat inside source static 200.3.1.1 114.5.14.254
    Router-B-Up(config)#ip nat inside source static 200.4.1.1 114.5.14.253
    Router-B-Up(config)#interface s0/1/0
    Router-B-Up(config-if)#ip nat inside
    Router-B-Up(config)#interface s0/1/1
    Router-B-Up(config-if)#ip nat outside
    Router-B-Up(config-if)#exit
    Router-B-Up#debug ip nat
    ```
  ],
  [],
)


== 验证&冗余 - 1.5min



= ACL - 3min



== 验证&冗余 - 1.5min

