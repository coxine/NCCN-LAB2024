#import "../../template.typ": *

#let title = "期末实验 Checklist 1A"
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
  [准备并组装5根Console线], [],
)

== 连接设备

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接网线：Switch-A `g1/0/1` <==> PC-A-Front], [],
  [连接Console线：Router-A-Up <==> PC-A-Front], [],
)

== 输命令

== 初始化电脑

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Front超级终端打开并成功显示], [],
  [确认PC-A-Front IP为`192.168.10.2`], [],
  [确认PC-A-Front 子网掩码为`255.255.255.0`], [],
  [确认PC-A-Front 网关为`192.168.10.1`], [],
)

== 第一次验证&冗余

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Front能`ping`通`192.168.10.3`], [],
  [确认PC-A-Front不能`ping`通`192.168.20.2`], [],
  [确认PC-A-Front不能`ping`通`192.168.20.3`], [],
)

== 配置Trunk

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-A-Front配置Router-A-Up
    ```shell
    Router(config)#hostname Router-A-Up
    Router-A-Up(config)#interface g0/0/0
    Router-A-Up(config-if)#no ip address
    Router-A-Up(config-if)#no shutdown
    Router-A-Up(config)#int g0/0/0.10
    Router-A-Up(config-if)#encapsulation dot1q 10
    Router-A-Up(config-if)#ip address 192.168.10.1 255.255.255.0
    Router-A-Up(config)#int g0/0/0.20
    Router-A-Up(config-if)#encapsulation dot1q 20
    Router-A-Up(config-if)#ip address 192.168.20.1 255.255.255.0
    ```],
  [],
)

== 第二次验证&冗余

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Front能`ping`通`192.168.20.2`], [],
  [确认PC-A-Front能`ping`通`192.168.10.3`], [],
  [确认PC-A-Front能`ping`通`192.168.20.3`], [],
)

= RIP

== 接线

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接串口线：Router-A-Up `s0/1/0` <==> Router-A-Mid `s0/1/0`], [],
  [连接串口线：Router-A-Mid `s0/1/1` <==> Router-A-Down `s0/1/0`], [],
)

== 输命令

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

== 验证&冗余

= NAT

= ACL

== 输命令

== 验证&冗余

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-A-Mid上确认Router-A-Mid不能`ping`通`200.2.1.2`], [],
)
