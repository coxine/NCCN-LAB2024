#import "../../template.typ": *

#let title = "期末实验 Checklist 2A"
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
  [与1A共同准备并组装6根Console线、5 根直通线、2 根交叉线], [],
)

== 连接设备 & 初始化 Switch - 2min

- Switch的 `Console` 端口在外侧左上角

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接Console线：Switch-A <==> PC-A-Mid], [],
  [在PC-A-Mid 初始化Switch-A，初始化完成，即输入`no`之后，立刻报告组长], [],
)

== 初始化电脑 & 配置 VLAN - 2min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [
    ```shell
    # 在PC-A-Mid配置Switch-A
    Switch> enable
    Switch# conf t
    Switch(config)# hostname Switch-A
    Switch-A(config)# vlan 10
    Switch-A(config)# vlan 20
    Switch-A(config)# int g1/0/23
    Switch-A(config-if)# sw mod tr
    Switch-A(config)# int g1/0/1
    Switch-A(config-if)# sw mod acc
    Switch-A(config-if)# sw acc vl 10
    Switch-A(config-if)# int g1/0/2
    Switch-A(config-if)# sw mod acc
    Switch-A(config-if)# sw acc vl 20
    ```],
  [],
)

== VLAN验证1 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Back能`ping`通`192.168.20.3`], [],
  [确认PC-A-Back不能`ping`通`192.168.10.2` `192.168.10.3`], [],
)

== 配置Trunk 1min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [
    ```shell
    # 在PC-A-Mid配置Switch-A
    Switch1(config)#int g1/0/24
    Switch1(config-if)#sw mod tr
    ```],
  [],
)

== VLAN验证2 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Back能`ping`通`192.168.10.2` `192.168.10.3` `192.168.20.3`], [],
)

= RIP - 6min

== 接线 - 2.5min

- Router的 `Console` 端口在外侧左下角


#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接Console线：Router-A-Down <==> PC-A-Back], [],
  [连接串口线：Router-A-Down `s0/1/1` <==> Router-B-Up `s0/1/0`，完毕直接下一步], [],
)

== 输入命令 - 3min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [
    ```shell
    # 在PC-A-Back配置Router-A-Down
    Router> enable
    Router# conf t
    Router(config)# no ip domain-lookup
    Router(config)# hostname Router-A-Down
    Router-A-Down(config)# int s0/1/0
    Router-A-Down(config-if)# ip addr 200.1.1.2 255.255.255.0
    Router-A-Down(config-if)# no sh
    Router-A-Down(config)# int s0/1/1
    Router-A-Down(config-if)# ip addr 200.2.1.1 255.255.255.0
    Router-A-Down(config-if)# no sh
    Router-A-Down(config)# router rip
    Router-A-Down(config-router)# net 200.1.1.0
    Router-A-Down(config-router)# net 200.2.1.0
    ```],
  [],
)

== 验证&冗余 - 0.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Back能`ping`通`200.3.1.2`], [],
)

= NAT - 3min

== 输命令 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [
    ```shell
    # 在PC-A-Back配置Router-A-Down
    Router-A-Down(config)# ip route 114.5.14.0 255.255.255.0 s0/1/1
    ```
  ],
  [],
)


== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在 PC-A-Back 上通过 Router-A-Down能`ping`通`114.5.14.1`], [],
)

= ACL - 3min

== 输命令

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在 PC-A-Back 上通过 Router-A-Down不能`ping`通`200.2.1.2`], [],
)


