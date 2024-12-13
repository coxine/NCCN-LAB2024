#import "../../template.typ": *

#let title = "期末实验 Checklist 2A"
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
  [准备5根直通线、2根交叉线], [],
)

== 连接设备

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接直通线：Switch-A `g1/0/2` <==> PC-A-Back], [],
  [连接Console线：Switch-A <==> PC-A-Mid], [],
)

== 输命令

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

== 初始化电脑

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Back 超级终端打开并成功显示], [],
  [确认PC-A-Back IP为`192.168.20.2`], [],
  [确认PC-A-Back 子网掩码为`255.255.255.0`], [],
  [确认PC-A-Back 网关为`192.168.20.1`], [],
)

== 第一次验证

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Back不能`ping`通`192.168.10.2`], [],
  [确认PC-A-Back不能`ping`通`192.168.10.3`], [],
  [确认PC-A-Back能`ping`通`192.168.20.3`], [],
)

== 配置Trunk

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-A-Mid配置Switch-A
    ```shell
    Switch1(config)#interface g1/0/24
    Switch1(config-if)#switchport mode trunk
    ```],
  [],
)


== 第二次验证&冗余

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Back能`ping`通`192.168.10.2`], [],
  [确认PC-A-Back能`ping`通`192.168.10.3`], [],
  [确认PC-A-Back能`ping`通`192.168.20.3`], [],
)

= RIP

== 接线

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [ 拔Console线：Switch-A <=/=> PC-A-Mid ], [],
  [ 连接Console线：Router-A-Mid <==> PC-A-Mid], [],
  [ 连接Console线：Router-A-Down <==> PC-A-Back], [],
)

== 输命令

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

== 验证&冗余

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-A-Back 上确认Router-A-Down能`ping`通`200.4.1.2`], [],
)

= NAT

== 输命令

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-A-Back配置Router-A-Down
    ```shell
    Router-A-Down(config)#ip nat inside source static 200.3.1.1 114.5.14.254
    Router-A-Down(config)#ip nat inside source static 200.4.1.1 114.5.14.253
    Router-A-Down(config)#interface s0/1/0
    Router-A-Down(config-if)#ip nat inside
    Router-A-Down(config)#interface s0/1/1
    Router-A-Down(config-if)#ip nat outside
    Router-A-Down(config-if)#exit
    Router-A-Down#debug ip nat
    ```],
  [],
)


== 验证&冗余

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-A-Back 上确认Router-A-Down能`ping`通`114.5.14.1`], [],
)

= ACL

== 输命令

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-A-Back配置Router-A-Down
    ```shell
    Router-A-Down(config)#access-list 100 deny icmp host 200.2.1.1 host 200.2.1.2
    Router-A-Down(config)#access-list 100 permit ip any any
    Router-A-Down(config)#interface s0/1/0
    Router-A-Down(config-if)#ip access-group 100 in
    ```],
  [],
)

== 验证&冗余

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-A-Back 上确认Router-A-Down能`ping`通`200.2.1.1`], [],
)

