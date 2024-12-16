#import "../../template.typ": *

#let title = "期末实验 Checklist 1B"
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
  [与2B共同准备并组装3组串口线], [],
)

== 连接设备 & 初始化 Switch - 2min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接直通线：Switch-B `g1/0/1` <==> PC-B-Front], [],
  [连接直通线：Switch-B `g1/0/2` <==> PC-B-Back], [],
)


== 初始化电脑 - 2min

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
  [确认PC-B-Front超级终端打开并成功显示], [],
  [修改PC-B-Front IP `192.168.10.3` 子网掩码 `255.255.255.0` 网关 `192.168.10.1`], [],
  [修改PC-B-Back IP `192.168.20.3` 子网掩码 `255.255.255.0` 网关 `192.168.20.1`], [],
)


== VLAN验证1 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Front能`ping`通`192.168.10.2`], [],
  [确认PC-B-Front不能`ping`通`192.168.20.2` `192.168.20.3`], [],
)

== 配置Trunk 1min

== VLAN验证2 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [确认PC-B-Front能`ping`通`192.168.10.2` `192.168.20.2` `192.168.20.3`], [],
)

= RIP - 6min

== 接线 - 2.5min

- Router的 `Console` 端口在外侧左下角

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [连接串口线：Router-B-Up `s0/1/1` <==> Router-B-Down `s0/1/0`], [],
  [连接Console线：Router-B-Up <==> PC-B-Front], [],
)

== 输命令 - 3min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [
    ```shell
    # 在PC-B-Front配置Router-B-Up
    Router> enable
    Router# conf t
    Router(config)# no ip domain-lookup
    Router(config)# hostname Router-B-Up
    Router-B-Up(config)# int s0/1/0
    Router-B-Up(config-if)# ip addr 200.2.1.2 255.255.255.0
    Router-B-Up(config-if)# no sh
    Router-B-Up(config)# int s0/1/1
    Router-B-Up(config-if)# ip addr 114.5.14.2 255.255.255.0
    Router-B-Up(config-if)# no sh
    Router-B-Up(config)# int g0/0/0
    Router-B-Up(config-if)# ip addr 200.3.1.1 255.255.255.0
    Router-B-Up(config-if)# no sh
    Router-B-Up(config)# router rip
    Router-B-Up(config-router)# net 200.2.1.0
    Router-B-Up(config-router)# net 200.3.1.0
    ```
  ],
  [],
)

== 验证&冗余 - 1.5min

= NAT - 3min

== 输命令 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [
    ```shell
    # 在PC-B-Front配置Router-B-Up
    Router-B-Up(config)# ip nat i s s 200.2.1.1 114.5.14.254
    Router-B-Up(config)# ip nat i s s 200.3.1.2 114.5.14.253
    Router-B-Up(config)# int s0/1/0
    Router-B-Up(config-if)# ip nat in
    Router-B-Up(config)# int s0/1/1
    Router-B-Up(config-if)# ip nat out
    Router-B-Up(config-if)# exit
    Router-B-Up# debug ip nat
    ```
  ],
  [],
)

== 验证&冗余 - 1.5min

= ACL - 3min

== 输命令 - 1.5min

#table(
  columns: (90%, 10%),
  align: (left, center),
  table.header[*操作*][*完成*],
  [
    ```shell
    # 在PC-B-Front配置Router-B-Up
    Router-B-Up(config)# access-list 100 deny icmp host 200.2.1.1 host 200.2.1.2
    Router-B-Up(config)# access-list 100 permit ip any any
    Router-B-Up(config)# interface s0/1/0
    Router-B-Up(config-if)# ip access-group 100 in
    ```
  ],
  [],
)

== 验证&冗余 - 1.5min
