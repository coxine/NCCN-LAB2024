#import "../../template.typ": *

#let title = "期末实验 Checklist M"
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
  [开启Switch-A], [],
  [开启Switch-B], [],
  [开启Router-A-Up], [],
  [开启Router-A-Mid], [],
  [开启Router-A-Down], [],
  [开启Router-B-Up], [],
  [开启Router-B-Mid], [],
  [确认1A完成], [],
  [确认1B完成], [],
  [确认2A完成], [],
  [确认2B完成], [],
)

== 连接设备 - 1min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接交叉线：Switch-A `g1/0/23` <==> Switch-B `g1/0/23`], [],
  [连接网线：Switch-A `g1/0/24` <==> Router-A-Up `g0/0/0`], [],
  [确认1A完成], [],
  [确认1B完成], [],
  [确认2A完成], [],
  [确认2B完成], [],
)

== 初始化电脑 - 1min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认1A完成], [],
  [确认1B完成], [],
  [确认2A完成], [],
  [确认2B完成], [],
)

== 输入命令 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认1A完成], [],
  [确认1B完成], [],
  [确认2A完成], [],
  [确认2B完成], [],
)

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认1A完成], [],
  [确认1B完成], [],
  [确认2A完成], [],
  [确认2B完成], [],
)

= RIP - 6min

== 接线 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认1A完成], [],
  [确认1B完成], [],
  [确认2A完成], [],
  [确认2B完成], [],
)

== 输入命令 - 3min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-A-Front配置Router-A-Up
    ```shell
    Router-A-Up(config)#interface s0/1/0
    Router-A-Up(config-if)#ip address 200.1.1.1 255.255.255.0
    Router-A-Up(config-if)#no shutdown
    Router-A-Up(config)#router rip
    Router-A-Up(config-router)#network 192.168.10.0
    Router-A-Up(config-router)#network 192.168.20.0
    Router-A-Up(config-router)#network 200.1.1.0
    ```],
  [],

  [确认1A完成], [],
  [确认1B完成], [],
  [确认2A完成], [],
  [确认2B完成], [],
)

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认1A完成], [],
  [确认1B完成], [],
  [确认2A完成], [],
  [确认2B完成], [],
)

= NAT - 3min

== 输命令 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认1A完成], [],
  [确认1B完成], [],
)

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认1A完成], [],
  [确认1B完成], [],
)

= ACL - 3min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认2A完成], [],
)

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认1A完成], [],
  [确认2A完成], [],
)
