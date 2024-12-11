#import "../../template.typ": *

#let title = "期末实验 Checklist 2B"
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
  [准备4根串口线], [],
)

== 连接设备 - 1min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接Console线：Switch-B <==> PC-B-Mid], [],
)

== 初始化电脑 - 1min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Front超级终端打开并成功显示], [],
  [确认PC-B-FrontIP为`192.168.20.3`], [],
  [确认PC-B-Front子网掩码为`255.255.255.0`], [],
  [确认PC-B-Front网关为`192.168.20.1`], [],
)

== 输入命令 - 1.5min


== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Front能`ping`通`192.168.20.2`], [],
  [确认PC-B-Front能`ping`通`192.168.10.2`], [],
  [确认PC-B-Front能`ping`通`192.168.10.3`], [],
)

= RIP - 6min

== 接线 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [拔Console线：Switch-B <=/=> PC-B-Mid], [],
  [连接Console线：Router-B-Up <==> PC-B-Front], [],
  [连接Console线：Router-B-Mid <==> PC-B-Mid], [],
)

== 输入命令 - 3min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-B-Mid配置Router-B-Mid
    ```shell
    Router(config)#hostname Router-B-Mid
    Router-B-Mid(config)#interface s0/1/0
    Router-B-Mid(config-if)#ip address 114.5.114.1
    Router-B-Mid(config-if)#no shutdown
    ```
  ],
  [],
)

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认Router-B-Mid不能`ping`通`200.2.1.2`], [],
  [确认Router-B-Mid不能`ping`通`200.3.1.2`], [],
  [确认Router-B-Mid不能`ping`通`200.1.1.2`], [],
)

= NAT - 3min

== 输命令 - 1.5min




== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认Router-B-Mid能`ping`通`114.5.14.254`], [],
  [确认Router-B-Mid能`ping`通`114.5.14.253`], [],
)

= ACL - 3min



== 验证&冗余 - 1.5min

