#import "../template.typ": *

#let title = "期末问答模拟 2024"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-12-23"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 基础知识

#cprob()[简述实验的拓扑形状及设备数量][
  #image("Final.png")

  #table(
    columns: (20%, 40%, 20%, 20%),
    table.header[*实验项目*][*路由器*][*交换机*][*PC*],
    [VLAN间路由], [1 (A-Up)], [2], [4],
    [RIP], [3 (A-Up, A-Down, B-Up)], [0], [5],
    [NAT], [2 (B-Up B-Down)], [0], [1 (B-Mid)],
    [ACL], [2 (A-Down, B-Up)], [0], [0],
    [*合计*], [4], [2], [5],
  )
]


#cprob()[简述各种线的差别][
  #table(
    columns: (20%, 20%, 60%),
    table.header[*种类*][*颜色*][*用途*],
    [串口线], [深蓝色], [连接路由器],
    [翻转串口线], [浅蓝色], [接在Console口上，用于PC控制路由器/交换机],
    [直通线], [黄色], [网线，连接交换机和PC/路由器],
    [交叉线], [紫色], [网线，连接两个交换机以及PC和Router],
  )
  注：交叉线和直通线已不作区分，均可自动识别
]

#cprob()[简述`ping`的概念][
  - 网络工具：测试网络连接的可达性和延迟
  - 协议：ICMP
  - 向目标主机发送 ICMP 回显请求，目标主机收到请求后，返回 ICMP 回显应答数据包
  - `ping` 工具会记录发送请求和接收应答的时间，并显示结果
]

= 路由

#cprob()[简述动态路由的作用][
  - 动态路由的作用：自动检测网络拓扑的变化（如路由器故障、链路中断等），更新路由表
  - RIP：Distance Vector 路由协议（基于跳数），最多 15 跳
]

#cprob()[简述实验中具体如何动态路由][
  #table(
    columns: (30%, 70%),
    table.header[*路由器*][*分配的IP网段*],
    [Router-A-Up], [`192.168.10.0`, `192.168.20.0`, `200.1.1.0`],
    [Router-A-Down], [`200.1.1.0`, `200.2.1.0`],
    [Router-B-Up], [`200.2.1.0`,`200.3.1.0`],
  )
]

#cprob()[在路由器上输入`show ip route` 解释输出][
  ```shell
  C    200.1.1.0/24 is directly connected, Serial2/0
  # C 开头表示直连路由 即通过Serial2/0接口连接到`200.1.1.0/24`
  # 对应 `ip address` 命令配置的地址
  R    200.2.1.0/24 [120/1] via 200.1.1.2, 00:00:17, Serial2/0
  # R 开头表示 RIP 上文即通过Serial2/0接口学习到的，通过`200.1.1.2`连接`200.2.1.0/24`
  # 对应`network`命令配置的地址
  # 120/1 表示距离/度量值
  ```
]

= VLAN

#cprob()[简述VLAN的作用][
  - 作用：隔离广播域，提高网络安全性
  - 联通不同VLAN：需要三层设备（路由器）来实现VLAN间路由
]

#cprob()[简述VLAN中子网的划分以及子网间如何连通][
  #table(
    columns: (20%, 40%, 40%),
    table.header[*项目*][*VLAN 10*][*VLAN 20*],
    [PC], [A-Front B-Front], [A-Back B-Back],
    [IP], [`192.168.10.0/24`], [`192.168.20.0/24`],
    [网关], [Router-A-Up `g0/0/0.10`], [Router-A-Up `g0/0/0.20`],
  )
  Switch间为Trunk链路，Switch-A连接Router-A-Up的接口为Trunk接口
]

#cprob()[简述VLAN中的Trunk技术][
  Trunk端口通过*在数据帧中添加VLAN标签*来区分不同VLAN的数据
]

= NAT & ACL

#cprob()[简述NAT的作用][
  转换内/公网IP地址，允许内网多个设备共享一个公网IP
]

#cprob()[验证实验中的NAT是有效的][
  在Router-B-Up上执行命令，查看NAT转换表：
  ```shell
  FinalRouter>show ip nat trans
  Pro  Inside global     Inside local       Outside local      Outside global
  ---  114.5.14.253      200.4.1.1          ---                ---
  ---  114.5.14.254      200.3.1.1          ---                ---
  ```

  执行`ping`命令：
  - 在 PC-A-Back 上通过 Router-A-Down 能`ping`通`114.5.14.1`
  - 在 PC-B-Back 上通过 Router-B-Down 能`ping`通`114.5.14.254` `114.5.14.253`
]

#cprob()[简述ACL的作用][
  允许/拒绝特定类型的流量

  在本实验中，ACL封杀了Router-A-Down到Router-B-Up的`ping`命令
]

#cprob()[验证实验中的ACL是有效的][
  在Router-B-Up上执行命令，查看ACL：
  ```shell
  FinalRouter> enable
  FinalRouter# show ip access-list
  Extended IP access list 100
      10 deny icmp host 200.2.1.1 host 200.2.1.2
      20 permit ip any any (33 match(es))
  ```
  执行`ping`命令：
  - 在 PC-A-Back 上通过 Router-A-Down 不能`ping`通`200.2.1.2`
]

#cprob()[简述ACL中的 Access-list number][
  - 1-99：标准ACL，仅根据源地址匹配
  - 100-199：扩展ACL，根据源地址、目的地址、协议、端口匹配
]


