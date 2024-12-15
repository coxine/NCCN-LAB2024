#import "../../template.typ": *

#let title = "期末实验 Checklist 1B"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-12-23"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= VLAN & Trunk - 11min

== 开机 准备串口线 - 2min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [准备并组装3根串口线],[]
)

== 连接设备 - 1min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接直通线：Switch-B `g1/0/1` <==> PC-B-Front], [],
  [连接直通线：Switch-B `g1/0/2` <==> PC-B-Back], [],
)

== 等待Switch初始化 - 1min
等待指示

== 初始化电脑 - 2min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Front超级终端打开并成功显示], [],
  [修改PC-B-Front IP address 为`192.168.10.3`], [],
  [修改PC-B-Front子网掩码为`255.255.255.0`], [],
  [修改PC-B-Front网关为`192.168.10.1`], [],
  [],[],
  [修改PC-B-Back IP address 为`192.168.20.2`], [],
  [修改PC-B-Back子网掩码为`255.255.255.0`], [],
  [修改PC-B-Back网关为`192.168.20.1`], [],
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
  [确认PC-B-Front能`ping`通`192.168.10.2`], [],
  [确认PC-B-Front不能`ping`通`192.168.20.2`], [],
  [确认PC-B-Front不能`ping`通`192.168.20.3`], [],
)

== 等待配置VLAN Trunk路由器 1min
等待


== VLAN验证2 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Front能`ping`通`192.168.10.2`], [],
  [确认PC-B-Front能`ping`通`192.168.20.2`], [],
  [确认PC-B-Front能`ping`通`192.168.20.3`], [],
)

= RIP - 6min

== 接线 - 2.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接串口线：Router-A-Down `s0/1/1` <==> Router-B-Up `s0/1/0`],[],
  [连接串口线：Router-B-Up `s0/1/1` <==> Router-B-Down `s0/1/0`],[],
  [连接Console线：Router-B-Up <==> PC-B-Front],[]
)

== 输入命令 - 3min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-B-Front配置Router-B-Up
```shell
Router(config)#hostname Router-B-Up
Router-B-Up(config)#interface s0/1/0
Router-B-Up(config-if)#ip address 200.2.1.2 255.255.255.0
Router-B-Up(config-if)#no shutdown
Router-B-Up(config)#interface s0/1/1
Router-B-Up(config-if)#ip address 114.5.14.2 255.255.255.0
Router-B-Up(config-if)#no shutdown
Router-B-Up(config)#interface g0/0/0
Router-B-Up(config-if)#ip address 200.3.1.1 255.255.255.0
Router-B-Up(config-if)#no shutdown
Router-B-Up(config)#router rip
Router-B-Up(config-router)#network 200.2.1.0
Router-B-Up(config-router)#network 200.3.1.0
```
  ],
  [],
)

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Front能`ping`通`200.3.1.2`], []
  
)

= NAT - 3min

== 输命令 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-B-Front配置Router-B-Up
  ```
Router-B-Up(config)#ip nat inside source static 200.2.1.1 114.5.14.254
Router-B-Up(config)#ip nat inside source static 200.3.1.2 114.5.14.253
Router-B-Up(config)#interface s0/1/0
Router-B-Up(config-if)#ip nat inside
Router-B-Up(config)#interface s0/1/1
Router-B-Up(config-if)#ip nat outside
Router-B-Up(config-if)#exit
Router-B-Up#debug ip nat
```
  ],
  [],
)


== 验证&冗余 - 1.5min



= ACL - 3min

== 输命令
#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在PC-B-Front配置Router-B-Up
```
Router-B-Up(config)#access-list 100 deny icmp host 200.2.1.1 host 200.2.1.2
Router-B-Up(config)#access-list 100 permit ip any any
Router-B-Up(config)#interface s0/1/0
Router-B-Up(config-if)#ip access-group 100 in
```
  ],[]
)

== 验证&冗余 - 1.5min

