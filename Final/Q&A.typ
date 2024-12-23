#import "../template.typ": *

#let title = "期末问答 2024"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-12-23"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 基础知识

#cprob()[简述实验的拓扑形状][
  // 在这里写下你的回答
  由两台交换机,4台PC(PC-A/B-Front/Back),1台路由器(Router-A-Up )构成VLAN间路由\
  由三台路由器(包含VLAN间路由的那一台Router-A-Up + Router-A-Down + Router-B-Up)使用动态RIP构成一个小网络\
  再由一台新的路由器(Router-B-Down )和前面参与了RIP但是没参与VLAN间路由的两台路由器( Router-A-Down + Router-B-Up )+一台新的PC(PC-B-Mid)一起完成NAT网络地址转换
]

#cprob()[简述实验的设备数量及位置][
  // 照葫芦画瓢，参考实验中的拓扑
  2台交换机,5台PC,4台路由器\
  位置参考前一问
]

#cprob()[简述各种线的差别][
串口线(深蓝色):在本实验中用于路由器之间的连接\
翻转串口线(浅蓝色):接在console口上,用于连接PC与路由器/交换机来对路由器/交换机通过超级终端进行控制\
直通线(黄色):网线,在本实验中用于连接交换机和PC/路由器
交叉线(紫色):网线,在本实验中用于连接两个交换机以及在NAT中连接PC-B-Mid和Router-B-Up
]

#cprob()[简述`ping`的概念][
ping 是一种网络工具，用于测试网络连接的可达性和延迟。\
它通过向目标主机发送 ICMP（Internet Control Message Protocol，互联网控制消息协议）回显请求，\
目标主机收到请求后，会返回一个 ICMP 回显应答数据包。`ping` 工具会记录发送请求和接收应答的时间。\
`ping` 会计算从发送请求到接收应答所需的时间（往返时间，RTT），并显示结果。
]

= 路由

#cprob()[简述动态路由的作用][
  // 简明扼要
  本实验中采用的动态路由协议为RIP
  动态路由能够自动检测网络拓扑的变化（如路由器故障、链路中断等），并自动更新路由表
]

#cprob()[简述实验中具体如何动态路由][
  // 照葫芦画瓢，参考实验中的拓扑
  给Router-A-Up分配3个IP网段: 192.168.10.0, 192.168.20.0, 200.1.1.0\
  给Router-A-Down分配2个IP网段: 200.1.1.0, 200.2.1.0\
  给Router-B-Up分配2个IP网段: 200.2.1.0, 200.3.1.0
]

#cprob()[在路由器上输入`show ip route` 解释输出][
  // 在 Packet Tracer 中输入 show ip route 命令，把输出贴在下面，同时解释各种含义（包括C S L R O等）
]

= VLAN

#cprob()[简述VLAN的作用][
  // 简明扼要
  不同的 Vlan 相互隔离广播域，因此，传统的以太网 ARP 方式的通信机制在这里是不可用的，需要在网络中添加三层设备（本实验中为路由器Router-A-Up）来实现VLAN间路由。
]

#cprob()[简述VLAN中子网的划分以及子网间如何连通][
  // 照葫芦画瓢，参考实验中的拓扑
  Switch划分两个VLAN，VLAN 10和VLAN 20，\
  PC中,front的两台在VLAN 10下,back的两台在VLAN 20下,\
  Router-A-Up在 g0/0/0划分两个子接口 g0/0/0.10和 g0/0/0.20,并分别作为VLAN 10 和VLAN 20的网关\
  Switch间为Trunk链路,Switch-A连接Router-A-up的接口为Trunk接口
]

#cprob()[简述VLAN中的Trunk技术][
  // 简明扼要
  Trunk端口通过在数据帧中添加VLAN标签来区分不同VLAN的数据
]

= NAT & ACL

#cprob()[简述NAT的作用][
  // 简明扼要
  在计算机网络中转换IP地址,允许多个设备共享一个公共IP地址
]

#cprob()[验证实验中的NAT是有效的][
  // 一个是`show ip nat translations`，一个是执行`ping`命令，看是否成功
]

#cprob()[简述ACL的作用][
  // 简明扼要
  ACL可以允许或拒绝特定类型的流量\
  在本实验中,ACL封杀了Router-A-Down到Router-B-Up的命令
]

#cprob()[验证实验中的ACL是有效的][
  // 一个是`show ip access-list`，一个是执行`ping`命令，看是否失败
]

#cprob()[简述ACL中的 Access-list number][
  // 列张表，参考ppt
]


