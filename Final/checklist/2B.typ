#import "../../template.typ": *

#let title = "期末实验 Checklist 2B"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-12-23"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= VLAN & Trunk - 10min

== 开机 准备线缆 - 2min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [与1B共同准备并组装3组串口线], [],
)


== 连接设备 & 初始化 Switch - 2min

- Switch的 `Console` 端口在外侧左上角


#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接Console线：Switch-B <==> PC-B-Mid], [],
  [在PC-B-Mid 初始化Switch-B，初始化完成，即输入`no`之后，立刻报告组长], [],
)

== 配置Switch-B 的 VLAN - 2min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [
    ```shell
    # 在PC-B-Mid配置Switch-B
    Switch> enable
    Switch# conf t
    Switch(config)# hostname Switch-B
    Switch-B(config)# vlan 10
    Switch-B(config)# vlan 20
    Switch-B(config)# int g1/0/23
    Switch-B(config-if)# sw mod tr
    Switch-B(config)# int g1/0/1
    Switch-B(config-if)# sw mod acc
    Switch-B(config-if)# sw acc vl 10
    Switch-B(config-if)# int g1/0/2
    Switch-B(config-if)# sw mod acc
    Switch-B(config-if)# sw acc vl 20
    ```],
  [],
)

== VLAN验证1 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Back能`ping`通`192.168.20.2`], [],
  [确认PC-B-Back不能`ping`通`192.168.10.2` `192.168.10.3`], [],
)

== 配置 Trunk路由器 1min

== VLAN验证2 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Back能`ping`通`192.168.10.2` `192.168.10.3` `192.168.20.2`], [],
)

= RIP - 6min

- Router的 `Console` 端口在外侧左下角

== 接线 - 2.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接Console线：Router-B-Down <==> PC-B-Back], [],
)

== 输入命令 - 3min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [
    ```shell
    # 在PC-B-Back配置Router-B-Down
    Router> enable
    Router# conf t
    Router(config)# no ip domain-lookup
    Router(config)# hostname Router-B-Down
    Router-B-Down(config)# int s0/1/0
    Router-B-Down(config-if)# ip addr 114.5.14.1 255.255.255.0
    Router-B-Down(config-if)# no sh
    ```
  ],
  [],
)


== 验证&冗余 - 0.5min

= NAT - 3min

== 输命令 - 1.5min

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在 PC-B-Back 上通过 Router-B-Down 能`ping`通`114.5.14.254` `114.5.14.253`], [],
)

= ACL - 3min


