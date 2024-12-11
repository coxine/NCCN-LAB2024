#import "../template.typ": *

#let title = "期末实验 拆解步骤"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-12-23"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 基础规范

== 操作规范

- 指差确认：插入直通线后，手指着网口说一遍“xx设备的yy网口已插好”
- 指令复诵：在终端输入命令前默读一遍，输入时大声复诵

== 人员&设备分布

- 面向讲台左侧为A区，右侧为B区
- 靠近讲台为前，靠近窗台为后
- 靠近天花板为上，靠近地板为下
- 中间站1人指挥（M），AB区各2人负责（1A 2A 1B 2B）


=== 网络设备

#table(
  columns: (25%, 25%, 25%, 25%),
  table.header[*机柜A*][*用途*][*机柜B*][*用途*],
  [Switch-A], [Switch1], [Switch-B], [Switch2],
  [Router-A-Up], [VlanController], [Router-B-Up], [FinalRouter],
  [Router-A-Mid], [TransRouter12], [Router-B-Mid], [-],
  [Router-A-Down], [TransRouter23], [Router-B-Down], [OutsideRouter],
)

=== PC

#table(
  columns: (25%, 25%, 25%, 25%),
  table.header[*A区*][*用途*][*B区*][*用途*],
  [PC-A-Front], [VLAN10PC1], [PC-B-Front], [VLAN10PC2],
  [PC-A-Mid], [], [PC-B-Mid], [PC4],
  [PC-A-Back], [VLAN20PC1], [PC-B-Back], [VLAN20PC2],
)

== 设备控制

#table(
  columns: (20%, 30%, 50%),
  table.header[*人员*][*控制端*][*被控端*],
  [1A], [PC-A-Front], [Router-A-Up],
  [2A], [PC-A-Mid], [Switch-A Router-A-Mid],
  [2A], [PC-A-Back], [Router-A-Down],
  [1B], [PC-B-Front], [Router-B-Up],
  [2B], [PC-B-Mid], [Switch-B],
  [2B], [PC-B-Back], [Router-B-Down],
)

= VLAN & Trunk - 12min

- 设备只涉及VLAN相关部分，即
  1. Router-A-Up
  2. Switch-A Switch-B
  3. PC-A-Front PC-A-Mid PC-A-Back PC-B-Front


== 开机 准备直通线 - 2min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥、开启所有交换机、路由器、电脑], [M],
  [准备并组装5根Console线], [1A],
  [准备5根直通线、2根交叉线], [2A],
  [准备并组装4组串口线], [1B 2B],
)

== 连接设备 - 2min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [
    - 指挥
    - 连接交叉线：Switch-A `g1/0/23` <==> Switch-B `g1/0/23`
    - 连接直通线：Switch-A `g1/0/24` <==> Router-A-Up `g0/0/0`
  ],
  [M],

  [
    - 连接直通线：Switch-A `g1/0/1` <==> PC-A-Front
    - 连接Console线：Router-A-Up <==> PC-A-Front
  ],
  [1A],

  [
    - 连接Console线：Switch-A <==> PC-A-Mid
    - 连接直通线：Switch-A `g1/0/2` <==> PC-A-Back
  ],
  [2A],

  [
    - 连接直通线：Switch-B `g1/0/1` <==> PC-B-Front
  ],
  [1B],

  [
    - 连接Console线：Switch-B <==> PC-B-Mid
    - 连接直通线：Switch-B `g1/0/2` <==> PC-B-Back
  ],
  [2B],
)

== 输入命令 - 2min

- 此时Switch-A、Switch-B、Router-A-Up已经开机成功
- 配置网络设备前须完成初始化操作，详见checklist

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥], [M],
  [在 PC-A-Mid 初始化超级终端并配置 Switch-A], [2A],
  [在 PC-B-Mid 初始化超级终端并配置 Switch-B], [2B],
)

== 初始化电脑 - 2min

此时电脑已经开机成功。

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥], [M],
  [配置PC-A-Front 的 IP], [1A],
  [配置PC-A-Back 的 IP], [2A],
  [配置PC-B-Front 的 IP], [1B],
  [配置PC-B-Back 的 IP], [2B],
)

== 第一次验证 - 1min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥], [M],
  [在 PC-A-Front 上
    - 能`ping`通`192.168.20.2`
    - 不能`ping`通`192.168.10.3`
    - 不能`ping`通`192.168.20.3`
  ],
  [1A],

  [在PC-A-Back 上
    - 能`ping`通`192.168.20.3`
    - 不能`ping`通`192.168.10.2`
    - 不能`ping`通`192.168.20.2`],
  [2A],

  [在PC-B-Front 上
    - 能`ping`通`192.168.10.2`
    - 不能`ping`通`192.168.10.3`
    - 不能`ping`通`192.168.20.3`],
  [1B],

  [在PC-B-Back 上
    - 能`ping`通`192.168.10.3`
    - 不能`ping`通`192.168.10.2`
    - 不能`ping`通`192.168.20.2`],
  [2B],
)

== 配置 Trunk - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥], [M],
  [在 PC-A-Front 配置 Router-A-Front], [1A],
  [在 PC-A-Mid 配置 Switch-A], [2A],
)

== 第二次验证&冗余 - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥], [M],
  [在 PC-A-Front 上
    - 能`ping`通`192.168.20.2`
    - 能`ping`通`192.168.10.3`
    - 能`ping`通`192.168.20.3`
  ],
  [1A],

  [在PC-A-Back 上
    - 能`ping`通`192.168.20.3`
    - 能`ping`通`192.168.10.2`
    - 能`ping`通`192.168.20.2`],
  [2A],

  [在PC-B-Front 上
    - 能`ping`通`192.168.10.2`
    - 能`ping`通`192.168.10.3`
    - 能`ping`通`192.168.20.3`],
  [1B],

  [在PC-B-Back 上
    - 能`ping`通`192.168.10.3`
    - 能`ping`通`192.168.10.2`
    - 能`ping`通`192.168.20.2`],
  [2B],
)

= RIP 6min

- 引入剩余设备
- 无需对Switch和除PC-B-Mid以外的PC进行配置

== 接线 - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [
    1. 指挥
    2. 协助连接串口线
  ],
  [M],

  [
    1. 连接串口线：Router-A-Up `s0/1/0` <==> Router-A-Mid `s0/1/0`
    2. 连接串口线：Router-A-Mid `s0/1/1` <==> Router-A-Down `s0/1/0`
  ],
  [1A],

  [
    1. 拔Console线：Switch-A <=/=> PC-A-Mid
    2. 连接Console线：Router-A-Mid <==> PC-A-Mid
    3. 连接Console线：Router-A-Down <==> PC-A-Back

  ],
  [2A],

  [
    1. 连接串口线：Router-A-Down `s0/1/1` <==> Router-B-Up `s0/1/0`
    2. 连接串口线：Router-B-Up `s0/1/1` <==> Router-B-Down `s0/1/0`
    3. 连接交叉线：Router-B-Up `g0/0/0` <==> PC-B-Mid
  ],
  [1B],

  [
    1. 拔Console线：Switch-B <=/=> PC-B-Mid
    2. 连接Console线：Router-B-Up <==> PC-B-Front
    3. 连接Console线：Router-B-Down <==> PC-B-Back
  ],
  [2B],
)

== 输入命令 - 3min

- 配置网络设备前须完成 Router-A-Mid、Router-A-Down、Router-B-Up、Router-B-Down 的初始化操作，详见checklist

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [
    1. 指挥
    2. 在 PC-A-Front 配置 Router-A-Up
  ],
  [M],

  [在 PC-A-Mid 初始化超级终端并配置 Router-A-Mid], [1A],
  [在 PC-A-Back 初始化超级终端并配置 Router-A-Down], [2A],
  [在 PC-B-Front 初始化超级终端并配置 Router-B-Up], [1B],
  [在 PC-B-Back 初始化超级终端并配置 Router-B-Down], [2B],
)

== 验证&冗余 - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [TODO],
)

= NAT - 3min

== 输命令 - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥], [M],
  [在 PC-A-Back 配置 Router-A-Down], [2A],
  [在 PC-B-Front 配置 Router-B-Up], [1B],
)

== 验证&冗余 - 1.5min

- Router-A-Down可以`ping`通Router-B-Down`114.5.14.1`。
- Router-B-Down可以`ping`通Router-A-Down的NAT地址`114.5.14.254`。
- Router-B-Down可以`ping`通PC-B-Mid的NAT地址`114.5.14.253`。

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥], [M],
  [在 PC-A-Back 上通过 Router-A-Down
    - 能`ping`通`114.5.14.1`],
  [2A],

  [在 PC-B-Back 上通过 Router-B-Down
    - 能`ping`通`114.5.14.254`
    - 能`ping`通`114.5.14.253`],
  [2B],
)

= ACL - 3min

== 输命令 - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥], [M],
  [在 PC-A-Back 配置 Router-A-Down], [2A],
)

== 验证&冗余 - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥], [M],
  [在 PC-A-Mid 上通过 Router-A-Mid
    - 不能`ping`通`200.2.1.2`],
  [2A],

  [在 PC-A-Back 上通过 Router-A-Down
    - 能`ping`通`200.2.1.1`
  ],
  [2B],
)