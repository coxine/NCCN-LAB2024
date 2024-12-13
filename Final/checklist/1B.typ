#import "../../template.typ": *

#let title = "期末实验 Checklist 1B"
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
  [连接直通线：Switch-B `g1/0/1` <==> PC-B-Front], [],
)

== 输命令

== 初始化电脑

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Front 超级终端打开并成功显示], [],
  [确认PC-B-Front IP为`192.168.10.3`], [],
  [确认PC-B-Front 子网掩码为`255.255.255.0`], [],
  [确认PC-B-Front 网关为`192.168.10.1`], [],
)

== 第一次验证

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Front 能`ping`通`192.168.10.2`], [],
  [确认PC-B-Front 不能`ping`通`192.168.20.2`], [],
  [确认PC-B-Front 不能`ping`通`192.168.20.3`], [],
)

== 配置Trunk

== 验证&冗余

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Front 能`ping`通`192.168.20.2`], [],
  [确认PC-B-Front 能`ping`通`192.168.10.2`], [],
  [确认PC-B-Front 能`ping`通`192.168.20.3`], [],
)

= RIP

== 接线

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接串口线：Router-A-Down `s0/1/1` <==> Router-B-Up `s0/1/0`], [],
  [连接串口线：Router-B-Up `s0/1/1` <==> Router-B-Down `s0/1/0`], [],
  [连接网线：Router-B-Up `g0/0/0` <==> PC-B-Mid], [],
)

== 输命令

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

== 验证&冗余

= NAT

== 输命令

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


== 验证&冗余

= ACL

