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

- 指差确认：插入网线后，手指着网口说一遍“xx设备的yy网口已插好”
- 指令复诵：在终端输入命令前默读一遍，输入时大声复诵

== 人员&设备分布

- 面向讲台左侧为A区，右侧为B区
- 靠近讲台为前，靠近窗台为后
- 靠近天花板为上，靠近地板为下
- 中间站1人指挥（M），AB区各2人负责（1A 2A 1B 2B）

#table(
  columns: (30%, 30%, 40%),
  table.header[*设备方位*][*俗称*][*全名*],
  [A区交换机], [Switch-A], [Switch0],
  [B区交换机], [Switch-B], [Switch1],
  [A区上路由器], [Router-A-Up], [VlanController],
  [A区中路由器], [Router-A-Mid], [TransRouter12],
  [A区下路由器], [Router-A-Down], [TransRouter23],
  [B区上路由器], [Router-B-Up], [FinalRouter],
  [B区中路由器], [Router-B-Mid], [OutsideRouter],
  [A区前电脑], [PC-A-Front], [VLAN10PC1],
  [A区中电脑], [PC-A-Mid], [VLAN20PC1],
  [A区后电脑], [PC-A-Back], [VLAN10PC2],
  [B区前电脑], [PC-B-Front], [VLAN20PC2],
  [B区中电脑], [PC-B-Mid], [PC4],
)

= VLAN & Trunk - 6min

- 设备只涉及VLAN相关部分，即
  1. Router-A-Up
  2. Switch-A Switch-B
  3. PC-A-Front PC-A-Mid PC-A-Back PC-B-Front


== 开机 准备网线 - 1min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥、开启所有交换机、路由器], [M],
  [开电脑], [1A],
  [准备5根Console线 2根放旁边], [1B],
  [准备7根网线 1根放旁边], [2A],
  [准备4根串口线 若未准备完成可在第4步继续], [2B],
)

== 连接设备 - 1min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [
    1. 指挥
    2. 连接网线：Switch-A `g1/0/23` <==> Switch-B `g1/0/23`
    3. 连接网线：Switch-A `g1/0/24` <==> Router-A-Up `g0/0/0`
  ],
  [M],

  [
    1. 连接网线：Switch-A `g1/0/1` <==> PC-A-Front
    2. 连接网线：Switch-A `g1/0/2` <==> PC-A-Mid
  ],
  [1A],

  [
    1. 连接网线：Switch-B `g1/0/1` <==> PC-A-Back
    2. 连接网线：Switch-B `g1/0/2` <==> PC-B-Front
  ],
  [1B],

  [
    1. 连接Console线：Router-A-Mid <==> PC-A-Mid
    2. 连接Console线：Switch-A <==> PC-A-Front
  ],
  [2A],

  [
    1. 连接Console线：Switch-B <==> PC-B-Front
  ],
  [2B],
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
  [1A 1B 2A 2B],
)

== 输入命令 - 1.5min

- 此时Switch-A、Switch-B、Router-A-Up已经开机成功
- 配置网络设备前须完成初始化操作，详见checklist

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥], [M],
  [配置 Switch-A], [1A],
  [配置 Router-A-Up], [1B],
  [配置 Switch-B], [2A],
  [继续4根串口线], [2B],
)

== 验证&冗余 - 1.5min

- 四台电脑互相`ping`对方，确保都能`ping`通

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
    1. 连接串口线：Router-A-Down `s0/1/1` <==> Router-B-Up `s0/1/0`
    2. 连接串口线：Router-B-Up `s0/1/1` <==> Router-B-Mid `s0/1/0`
  ],
  [1B],

  [
    1. 拔Console线：Switch-A <=/=> PC-A-Mid
    2. 连接Console线：Router-A-Up <==> PC-A-Front
    3. 连接Console线：Router-A-Down <==> PC-A-Back

  ],
  [2A],

  [
    1. 拔Console线：Switch-B <=/=> PC-B-Front
    2. 连接Console线：Router-B-Up <==> PC-B-Front
    3. 连接Console线：Router-B-Mid <==> PC-B-Mid
    4. 连接网线：Router-B-Up `g0/0/0` <==> PC-B-Mid
  ],
  [2B],
)

== 输入命令 - 3min

- 配置网络设备前须完成Router-A-Down - 4的初始化操作，详见checklist

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [
    1. 指挥
    2. 配置 Router-A-Up
  ],
  [M],

  [配置 Router-A-Mid], [1A],
  [配置 Router-A-Down], [2A],
  [配置 Router-B-Up], [1B],
  [配置 Router-B-Mid], [2B],
)

== 验证&冗余 - 1.5min

- 除了Router-B-Mid以外的设备互相`ping`对方，确保都能`ping`通

= NAT - 3min

== 输命令 - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥], [M],
  [配置 Router-A-Down], [1A],
  [配置 Router-B-Up], [1B],
)

== 验证&冗余 - 1.5min

- Router-A-Down可以`ping`通Router-B-Mid。
- Router-B-Mid可以`ping`通Router-A-Down的NAT地址`114.5.14.254`。
- Router-B-Mid可以`ping`通PC-B-Mid的NAT地址`114.5.14.253`。

= ACL - 3min

== 输命令 - 1.5min

#table(
  columns: (80%, 20%),
  align: (left, center),
  table.header[*操作*][*人员*],
  [指挥], [M],
  [配置 Router-A-Down], [2A],
)

== 验证&冗余 - 1.5min

- Router-A-Mid不可以`ping`通Router-A-Down。但是可以`ping`通除此之外的所有设备。
- Router-A-Down 不受影响。