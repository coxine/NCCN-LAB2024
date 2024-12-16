#import "../../template.typ": *

#let title = "期末实验 Checklist M"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-12-23"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= VLAN & Trunk - 10.5min

== 开机 准备线缆 - 2min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在A区开启Switch-A Router-A-Up Router-A-Down], [],
  [在B区开启Switch-B Router-B-Up Router-B-Down], [],
  [开启A区3台电脑], [],
  [开启B区3台电脑], [],
  [确认1A 2A完成], [],
  [确认1B 2B完成], [],
)

== 连接设备 & 初始化 Switch - 2min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接交叉线：Switch-A `g1/0/23` <==> Switch-B `g1/0/23`], [],
  [连接网线：Switch-A `g1/0/24` <==> Router-A-Up `g0/0/0`], [],
  [确认全员完成], [],
)

== 初始化电脑 & 配置 VLAN - 2min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [修改PC-B-Mid IP `200.3.1.2` 子网掩码 `255.255.255.0` 网关 `200.3.1.1`], [],
  [确认全员完成], [],
)

== 第一次验证 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认全员完成], [],
)

== 配置 Trunk - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认全员完成], [],
)

== 第二次验证 & 冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认全员完成], [],
)


= RIP - 6min

== 接线 - 2.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接交叉线：Router-B-Up `g0/0/0` <==> PC-B-Mid], [],
  [确认全员完成], [],
)

== 输入命令 - 3min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认全员完成], [],
)

== 验证&冗余 - 0.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认2A完成], [],
)

= NAT - 3min

== 输命令 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认2A完成], [],
  [确认1B完成], [],
)

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认2A完成], [],
  [确认2B完成], [],
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
