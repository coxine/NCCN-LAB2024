#import "../../template.typ": *

#let title = "期末实验 Checklist 2B"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-12-23"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= VLAN & Trunk

== 开机 准备网线

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [1B 2B共同组装4组串口线], [],
)

== 连接设备

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接Console线：Switch-B <==> PC-B-Mid], [],
  [连接直通线：Switch-B `g1/0/2` <==> PC-B-Back], [],
)

== 输命令

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

== 初始化电脑

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Back 超级终端打开并成功显示], [],
  [确认PC-B-Back IP为`192.168.20.3`], [],
  [确认PC-B-Back 子网掩码为`255.255.255.0`], [],
  [确认PC-B-Back 网关为`192.168.20.1`], [],
)

== 第一次验证

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Back 能`ping`通`192.168.20.2`], [],
  [确认PC-B-Back 不能`ping`通`192.168.10.2`], [],
  [确认PC-B-Back 不能`ping`通`192.168.10.3`], [],
)

== 配置Trunk

== 验证&冗余

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Back 能`ping`通`192.168.20.2`], [],
  [确认PC-B-Back 能`ping`通`192.168.10.2`], [],
  [确认PC-B-Back 能`ping`通`192.168.10.3`], [],
)

= RIP

== 接线

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [拔Console线：Switch-B <=/=> PC-B-Mid], [],
  [连接Console线：Router-B-Up <==> PC-B-Front], [],
  [连接Console线：Router-B-Down <==> PC-B-Back], [],
)

== 输命令

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-B-Back配置Router-B-Down
    ```shell
    Router(config)#hostname Router-B-Down
    Router-B-Down(config)#interface s0/1/0
    Router-B-Down(config-if)#ip address 114.5.114.1
    Router-B-Down(config-if)#no shutdown
    ```
  ],
  [],
)

== 验证&冗余


= NAT

== 输命令


== 验证&冗余

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-B-Back 上确认Router-B-Down能`ping`通`114.5.14.254`], [],
  [在PC-B-Back 上确认Router-B-Down能`ping`通`114.5.14.253`], [],
)

= ACL


