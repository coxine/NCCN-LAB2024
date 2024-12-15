#import "../../template.typ": *

#let title = "期末实验 Checklist 1A"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-12-23"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= VLAN & Trunk - 10min

== 开机 准备直通线 - 2min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [准备并组装5根Console线],[],
  [开启PC-A-Front], [],
)

== 连接设备 - 1min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接直通线：Switch-A `g1/0/1` <==> PC-A-Front], [],
  [连接直通线：Switch-A `g1/0/2` <==> PC-A-Back], [],
  [连接直通线：Switch-A `g1/0/24` <==> Router-A-Up `g0/0/0`], [],
  [连接Concole线：Router-A-Up `Concole` <==> PC-A-Front], [],
)

== 等待Switch初始化 - 1min
等待指示

== 初始化电脑 - 2min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Front超级终端打开并成功显示], [],
  [修改PC-A-Front IP address 为`192.168.10.2`], [],
  [修改PC-A-Front子网掩码为`255.255.255.0`], [],
  [修改PC-A-Front网关为`192.168.10.1`], [],
  [],[],
  [修改PC-A-Back IP address 为`192.168.20.2`], [],
  [修改PC-A-Back子网掩码为`255.255.255.0`], [],
  [修改PC-A-Back网关为`192.168.20.1`], [],
)

如何修改IP address 及其相关配置：
1. 右击右下角 网络图标 -> "网络和Internet"
2. 找到“更改适配器选项”
3. 如果Switch初始化好了就会有第三个以太网连接，双击 -> 属性 -> 选择 “Internet版本协议4"
4. 上半部分, 勾选"使用下面的IP地址"


== VLAN验证1  - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Front能`ping`通`192.168.10.3`], [],
  [确认PC-A-Front不能`ping`通`192.168.20.2`], [],
  [确认PC-A-Front不能`ping`通`192.168.20.3`], [],
)

== 配置VLAN Trunk路由器 1min

```shell
Router(config)#hostname VlanController
VlanController(config)#interface g0/0/0
VlanController(config-if)#no ip address
VlanController(config-if)#no shutdown
VlanController(config)#int g0/0/0.10
VlanController(config-if)#encapsulation dot1q 10
VlanController(config-if)#ip address 192.168.10.1 255.255.255.0
VlanController(config)#int g0/0/0.20
VlanController(config-if)#encapsulation dot1q 20
VlanController(config-if)#ip address 192.168.20.1 255.255.255.0
```

== VLAN验证2 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Front能`ping`通`192.168.10.3`], [],
  [确认PC-A-Front能`ping`通`192.168.20.2`], [],
  [确认PC-A-Front能`ping`通`192.168.20.3`], [],
)

= RIP - 6min

== 接线 - 2.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接串口线：Router-A-Up `s0/1/1` <==> Router-A-Down `s0/1/0`],[]
)
连接完成后请立刻开始配置Router，无需报告

== 输入命令 - 3min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-A-Front配置Router-A-Up
    ```shell
    Router(config)#hostname Router-A-Up
    Router-A-Up(config)#interface s0/1/0
    Router-A-Up(config-if)#ip address 200.1.1.1 255.255.255.0
    Router-A-Up(config-if)#no shutdown
    Router-A-Up(config)#router rip
    Router-A-Up(config-router)#network 192.168.10.0
    Router-A-Up(config-router)#network 192.168.20.0
    Router-A-Up(config-router)#network 200.1.1.0
    ```],
  [],
)

== 验证&冗余 - 0.5min

= NAT - 3min

= ACL - 3min

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认Router-A-Mid不能`ping`通`200.2.1.2`], [],
)
