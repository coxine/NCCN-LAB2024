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

1. 人员分布：中间站1人指挥（M），左右两侧各2人负责（1L 2L 1R 2R）
2. 指差确认：插入网线后，手指着网口说一遍“xx设备的yy网口已插好”
3. 指令复诵：在终端输入命令前默读一遍，输入时大声复诵

= VLAN & Trunk - 6min

- 设备只涉及VLAN相关部分，即
  1. Router0
  2. Switch0 Switch1
  3. PC0 PC1 PC2 PC3


== 开机 准备网线 - 1min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥、开启所有交换机、路由器], [M],
  [开电脑], [1L],
  [准备5根Console线 2根放旁边], [1R],
  [准备7根网线 1根放旁边], [2L],
  [准备4根串口线 若未准备完成可在第4步继续], [2R],
)

== 连接设备 - 1min


#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [
    1. 指挥
    2. 连接网线：Switch0 `g1/0/23` <==> Switch1 `g1/0/23`
    3. 连接网线：Switch0 `g1/0/24` <==> Router0 `g0/0/0`
  ],
  [M],

  [
    1. 连接网线：Switch0 `g1/0/1` <==> PC0
    2. 连接网线：Switch0 `g1/0/2` <==> PC1
  ],
  [1L],

  [
    1. 连接网线：Switch1 `g1/0/1` <==> PC2
    2. 连接网线：Switch1 `g1/0/2` <==> PC3
  ],
  [1R],

  [
    1. 连接Console线：Router1 <==> PC1
    2. 连接Console线：Switch0 <==> PC0
  ],
  [2L],

  [
    1. 连接Console线：Switch1 <==> PC3
  ],
  [2R],
)

== 初始化电脑 - 1min

此时电脑已经开机成功。

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥], [M],
  [
    1. 4台PC配置IP
    2. 3台连接Console线的PC连接超级终端
  ],
  [1L 1R 2L 2R],
)

== 输入命令 - 1.5min

- 此时Switch0、Switch1、Router0已经开机成功
- 配置网络设备前须完成初始化操作，详见checklist

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥], [M],
  [配置 Switch0], [1L],
  [配置 Router0], [1R],
  [配置 Switch1], [2L],
  [继续4根串口线], [2R],
)

== 验证&冗余 - 1.5min

- 四台电脑互相`ping`对方，确保都能`ping`通

= RIP 6min

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
    1. 连接串口线：Router0 `s0/1/0` <==> Router1 `s0/1/0`
    2. 连接串口线：Router1 `s0/1/1` <==> Router2 `s0/1/0`
  ],
  [1L],

  [
    1. 连接串口线：Router2 `s0/1/1` <==> Router3 `s0/1/0`
    2. 连接串口线：Router3 `s0/1/1` <==> Router4 `s0/1/0`
  ],
  [1R],

  [
    1. 拔Console线：Switch0 <=/=> PC1
    2. 连接Console线：Router0 <==> PC0
    3. 连接Console线：Router2 <==> PC2

  ],
  [2L],

  [
    1. 拔Console线：Switch1 <=/=> PC3
    2. 连接Console线：Router3 <==> PC3
    3. 连接Console线：Router4 <==> PC4
    4. 连接网线：Router3 `g0/0/0` <==> PC4
  ],
  [2R],
)

== 输入命令 - 3min

- 配置网络设备前须完成Router2 - 4的初始化操作，详见checklist

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [
    1. 指挥
    2. 配置 Router0
  ],
  [M],

  [配置 Router1], [1L],
  [配置 Router2], [2L],
  [配置 Router3], [1R],
  [配置 Router4], [2R],
)

== 验证&冗余 - 1.5min

- 除了Router4以外的设备互相`ping`对方，确保都能`ping`通

= NAT - 3min

== 输命令 - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥], [M],
  [配置 Router2], [1L],
  [配置 Router3], [1R],
)

== 验证&冗余 - 1.5min

- Router2可以`ping`通Router4。
- Router4可以`ping`通Router2的NAT地址`114.5.14.254`。
- Router4可以`ping`通PC4的NAT地址`114.5.14.253`。

= ACL - 3min

- todo 今天先不做