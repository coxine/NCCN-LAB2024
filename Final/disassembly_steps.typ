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
- 指令复诵：在终端输命令前默读一遍，输入时大声复诵

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
  [Router-A-Mid], [-], [Router-B-Mid], [-],
  [Router-A-Down], [TransRouter], [Router-B-Down], [OutsideRouter],
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
  [1A 2A], [PC-A-Mid], [Switch-A],
  [2A], [PC-A-Back], [Router-A-Down],
  [1B], [PC-B-Front], [Router-B-Up],
  [1B 2B], [PC-B-Mid], [Switch-B],
  [2B], [PC-B-Back], [Router-B-Down],
)

= VLAN & Trunk - 10.5min

== 开机 准备线缆 - 2min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥、开启所有交换机、路由器、电脑], [M],
  [准备并组装6根Console线、5根直通线、2根交叉线], [1A 2A],
  [准备并组装3组串口线], [1B 2B],
)

== 连接设备 & 初始化 Switch - 2min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [
    - 连接交叉线：Switch-A `g1/0/23` <==> Switch-B `g1/0/23`
    - 连接直通线：Switch-A `g1/0/24` <==> Router-A-Up `g0/0/0`
  ],
  [M],

  [
    - 连接直通线：Switch-A `g1/0/1` <==> PC-A-Front
    - 连接Console线：Router-A-Up <==> PC-A-Front
    - 连接直通线：Switch-A `g1/0/2` <==> PC-A-Back
  ],
  [1A],

  [
    - 连接Console线：Switch-A <==> PC-A-Mid
    - 初始化Switch-A
  ],
  [2A],

  [
    - 连接直通线：Switch-B `g1/0/1` <==> PC-B-Front
    - 连接直通线：Switch-B `g1/0/2` <==> PC-B-Back
  ],
  [1B],

  [
    - 连接Console线：Switch-B <==> PC-B-Mid
    - 初始化Switch-B
  ],
  [2B],
)


== 初始化电脑 & 配置VLAN - 2min


#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [配置PC-B-Mid 的IP], [M],
  [配置PC-A-Front PC-A-Back 的 IP], [1A],
  [配置PC-B-Front PC-B-Back 的 IP], [1B],
  [在 PC-A-Mid 配置Switch-A 的VLAN], [2A],
  [在 PC-B-Mid 配置Switch-B 的VLAN], [2B],
)

== 第一次验证 - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [在 PC-A-Front 上
    - 能`ping`通`192.168.10.3`
    - 不能`ping`通`192.168.20.2`
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
    - 能`ping`通`192.168.20.2`
    - 不能`ping`通`192.168.10.2`
    - 不能`ping`通`192.168.10.3`],
  [2B],
)

== 配置 Trunk - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [在 PC-A-Front 配置 Router-A-Up], [1A],
  [在 PC-A-Mid 配置 Switch-A], [2A],
)

== 第二次验证&冗余 - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
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

== 接线 - 2.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [连接交叉线：Router-B-Up `g0/0/0` <==> PC-B-Mid], [M],
  [连接串口线：Router-A-Up `s0/1/0` <==> Router-A-Down `s0/1/0` ], [1A],
  [
    1. 连接Console线：Router-A-Down <==> PC-A-Back
    2. 连接串口线：Router-A-Down `s0/1/1` <==> Router-B-Up `s0/1/0`
  ],
  [2A],

  [
    1. 连接串口线：Router-B-Up `s0/1/1` <==> Router-B-Down `s0/1/0`
    2. 连接Console线：Router-B-Up <==> PC-B-Front
  ],
  [1B],

  [连接Console线：Router-B-Down <==> PC-B-Back], [2B],
)

== 输命令 - 3min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [在 PC-A-Front 配置 Router-A-Up], [1A],
  [在 PC-A-Back 初始化超级终端并配置 Router-A-Down], [2A],
  [在 PC-B-Front 初始化超级终端并配置 Router-B-Up], [1B],
  [在 PC-B-Back 初始化超级终端并配置 Router-B-Down], [2B],
)

== 验证&冗余 - 0.5min

- 取最长的拓扑链路证明中途RIP的完整性

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [PC-A-Back 可以 `ping` 通 PC-B-Mid ], [2A],
)

= NAT - 3min

== 输命令 - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [在 PC-A-Back 配置 Router-A-Down], [2A],
  [在 PC-B-Front 配置 Router-B-Up], [1B],
)

== 验证&冗余 - 1.5min
#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [在 PC-A-Back 上通过 Router-A-Down 能`ping`通`114.5.14.1`], [2A],
  [在 PC-B-Back 上通过 Router-B-Down 能`ping`通`114.5.14.254` `114.5.14.253`], [2B],
)

= ACL - 3min

== 输命令 - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [在 PC-B-Front 配置 Router-B-Up], [1B],
)

== 验证&冗余 - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [在 PC-A-Front 上通过 Router-A-Up 能`ping`通`200.2.1.2` ], [1A],
  [在 PC-A-Back 上通过 Router-A-Down 不能`ping`通`200.2.1.2`], [2A],
)