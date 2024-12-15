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

== 开机 准备网线 - 2min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [准备5根直通线 2根交叉线], [],
)

== 连接设备 - 0.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接Console线：Switch-A <==> PC-A-Mid], [],
)

完成后请立刻自行初始化Switch

== Switch初始化 - 1.5min
初始化完成立刻报告组长

注意是初始化完成，即输入`no`之后

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [初始化Switch-A], [],
)

== 配置Switch-A 的 VLAN - 2min

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

== VLAN验证1  - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Back能`ping`通`192.168.20.3`], [],
  [确认PC-A-Back不能`ping`通`192.168.10.2`], [],
  [确认PC-A-Back不能`ping`通`192.168.10.3`], [],
)

== 等待配置VLAN Trunk路由器 1min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
[在PC-A-Mid配置Switch-A```shell
Switch1(config)#interface g1/0/24
Switch1(config-if)#switchport mode trunk
```],[]
)

== VLAN验证2 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Back能`ping`通`192.168.10.2`], [],
  [确认PC-A-Back能`ping`通`192.168.10.3`], [],
  [确认PC-A-Back能`ping`通`192.168.20.3`], [],
)

= RIP - 6min

== 接线 - 2.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接Console线：Router-A-Down <==> PC-A-Back],[]
)

连接完成后请立刻开始配置Router，无需报告

== 输入命令 - 3min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-A-Back配置Router-A-Down
    ```shell
    Router(config)#hostname Router-A-Down
    Router-A-Down(config)#interface s0/1/0
    Router-A-Down(config-if)#ip address 200.2.1.2 255.255.255.0
    Router-A-Down(config-if)#no shutdown
    Router-A-Down(config)#interface s0/1/1
    Router-A-Down(config-if)#ip address 200.3.1.1 255.255.255.0
    Router-A-Down(config-if)#no shutdown
    Router-A-Down(config)#router rip
    Router-A-Down(config-router)#network 200.2.1.0
    Router-A-Down(config-router)#network 200.3.1.0
    ```],
  [],
)

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认Router-A-Down能`ping`通`200.1.1.2`], [],
  [确认Router-A-Down能`ping`通`200.3.1.2`], [],
  [确认Router-A-Down能`ping`通`200.4.1.2`], [],
  [确认PC-A-Back能`ping`通`200.4.1.2`], [],
)

= NAT - 3min

== 输命令 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-A-Back配置Router-A-Down
  ```
Router-A-Down(config)#ip route 114.5.14.0 255.255.255.0 s0/1/1
```
  ],
  [],
)


== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认Router-A-Down能`ping`通`114.5.14.1`], [],
)

= ACL - 3min
== 输命令

== 验证&冗余 - 1.5min
#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认Router-A-Down不能`ping`通`200.2.1.2`], [],
)


