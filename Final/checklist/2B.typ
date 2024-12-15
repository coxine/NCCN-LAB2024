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

== 开机 准备串口线 - 2min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [准备并组装3根串口线],[]
)

== 连接设备 - 0.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接Console线：Switch-B <==> PC-B-Mid], [],
)

== Switch初始化 - 1.5min
初始化完成立刻报告组长

注意是初始化完成，即输入`no`之后

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [初始化Switch-B], [],
)

== 配置Switch-B 的 VLAN - 2min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-B-Mid配置Switch-B
    ```shell
    Switch(config)#hostname Switch-B
    Switch-B(config)vlan 10
    Switch-B(config)#vlan 20
    Switch-B(config)#interface g1/0/23
    Switch-B(config-if)#switchport mode trunk
    Switch-B(config)#interface g1/0/1
    Switch-B(config-if)#switchport mode access
    Switch-B(config-if)#switchport access vlan 10
    Switch-B(config-if)#interface g1/0/2
    Switch-B(config-if)#switchport mode access
    Switch-B(config-if)#switchport access vlan 20
    ```],
  [],
)

== VLAN验证1  - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Back能`ping`通`192.168.20.2`], [],
  [确认PC-B-Back不能`ping`通`192.168.10.2`], [],
  [确认PC-B-Back不能`ping`通`192.168.10.3`], [],
)

== 等待配置VLAN Trunk路由器 1min

等待指示

== VLAN验证2 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Back能`ping`通`192.168.10.2`], [],
  [确认PC-B-Back能`ping`通`192.168.10.3`], [],
  [确认PC-B-Back能`ping`通`192.168.20.2`], [],
)

= RIP - 6min

== 接线 - 2.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [拔Console线：Switch-B <=/=> PC-B-Mid],[],
  [连接交叉线：Router-B-Up `g0/0/0` <==> PC-B-Mid],[],
  [连接Console线：Router-B-Down <==> PC-B-Back],[]
)

== 输入命令 - 3min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-B-Back配置Router-B-Down
```shell
Router(config)# hostname Router-B-Down
Router-B-Down(config)#interface s0/1/0
Router-B-Down(config-if)#ip address 114.5.114.1
Router-B-Down(config-if)#no shutdown
```
  ],
  [],
  [],[],
  [修改PC-B-Mid IP address 为`200.3.1.2`], [],
  [修改PC-B-Mid子网掩码为`255.255.255.0`], [],
  [修改PC-B-Mid网关为`200.3.1.1`], [],
)

如何修改IP address 及其相关配置：
1. 右击右下角 网络图标 -> "网络和Internet"
2. 找到“更改适配器选项”
3. 找到第三个以太网连接，双击 -> 属性 -> 选择 “Internet版本协议4"
4. 上半部分, 勾选"使用下面的IP地址"

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
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

