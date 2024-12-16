#import "../../template.typ": *

#let title = "期末实验 Checklist 1A"
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
  [与2A共同准备并组装6根Console线、5 根直通线、2 根交叉线], [],
)

== 连接设备 & 初始化 Switch - 2min

- Router的 `Console` 端口在外侧左下角

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接直通线：Switch-A `g1/0/1` <==> PC-A-Front], [],
  [连接直通线：Switch-A `g1/0/2` <==> PC-A-Back], [],
  [连接Concole线：Router-A-Up `Console` <==> PC-A-Front], [],
)

== 初始化电脑 & 配置 VLAN - 2min

- 未得到明确指挥前不得配置IP
- 如何修改IP address 及其相关配置：
  1. 右击任务栏右下角 网络图标 -> “网络和Internet”
  2. 找到“更改适配器选项”
  3. 如果Switch初始化好了就会有第三个以太网连接，双击 -> 属性 -> 选择 “Internet版本协议4”
  4. 在窗口上半部分, 勾选“使用下面的IP地址”，对应修改


#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Front超级终端打开并成功显示], [],
  [修改PC-A-Front IP `192.168.10.2` 子网掩码 `255.255.255.0` 网关 `192.168.10.1`], [],
  [修改PC-A-Back IP `192.168.20.2` 子网掩码 `255.255.255.0` 网关 `192.168.20.1`], [],
)

== 第一次验证 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Front能`ping`通`192.168.10.3` ], [],
  [确认PC-A-Front不能`ping`通`192.168.20.2` `192.168.20.3`], [],
)

== 配置 Trunk - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [ ```shell
    # 在PC-A-Front配置Router-A-Up
    Router> enable
    Router# conf t
    Router(config)# hostname Router-A-Up
    Router-A-Up(config)# no ip domain-lookup
    Router-A-Up(config)# int g0/0/0
    Router-A-Up(config-if)# no ip addr
    Router-A-Up(config-if)# no sh
    Router-A-Up(config)# int g0/0/0.10
    Router-A-Up(config-if)# encap dot1q 10
    Router-A-Up(config-if)# ip addr 192.168.10.1 255.255.255.0
    Router-A-Up(config)# int g0/0/0.20
    Router-A-Up(config-if)# encap dot1q 20
    Router-A-Up(config-if)# ip addr 192.168.20.1 255.255.255.0
    ```],
  [],
)

== VLAN验证2 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-A-Front能`ping`通`192.168.10.3` `192.168.20.2` `192.168.20.3`], [],
)

= RIP - 6min

== 接线 - 2.5min


#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接串口线：Router-A-Up `s0/1/0` <==> Router-A-Down `s0/1/0`，完毕直接下一步], [],
)

== 输入命令 - 3min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [
    ```shell
    # 在PC-A-Front配置Router-A-Up
    Router-A-Up(config)#int s0/1/0
    Router-A-Up(config-if)#ip addr 200.1.1.1 255.255.255.0
    Router-A-Up(config-if)#no sh
    Router-A-Up(config)#router rip
    Router-A-Up(config-router)#net 192.168.10.0
    Router-A-Up(config-router)#net 192.168.20.0
    Router-A-Up(config-router)#net 200.1.1.0
    ```],
  [],
)

== 验证&冗余 - 0.5min

= NAT - 3min

= ACL - 3min

== 输命令

== 验证&冗余 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [在 PC-A-Front 上通过 Router-A-Up能`ping`通`200.2.1.2`], [],
)
