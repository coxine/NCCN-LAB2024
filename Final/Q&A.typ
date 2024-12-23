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
]

#cprob()[简述实验的设备数量及位置][
  // 照葫芦画瓢，参考实验中的拓扑
]

#cprob()[简述各种线的差别][

]

#cprob()[简述`ping`的概念][

]

= 路由

#cprob()[简述动态路由的作用][
  // 简明扼要
]

#cprob()[简述实验中具体如何动态路由][
  // 照葫芦画瓢，参考实验中的拓扑
]

#cprob()[在路由器上输入`show ip route` 解释输出][
  // 在 Packet Tracer 中输入 show ip route 命令，把输出贴在下面，同时解释各种含义（包括C S L R O等）
]

= VLAN

#cprob()[简述VLAN的作用][
  // 简明扼要
]

#cprob()[简述VLAN中子网的划分以及子网间如何连通][
  // 照葫芦画瓢，参考实验中的拓扑
]

#cprob()[简述VLAN中的Trunk技术][
  // 简明扼要
]

= NAT & ACL

#cprob()[简述NAT的作用][
  // 简明扼要
]

#cprob()[验证实验中的NAT是有效的][
  // 一个是`show ip nat translations`，一个是执行`ping`命令，看是否成功
]

#cprob()[简述ACL的作用][
  // 简明扼要
]

#cprob()[验证实验中的ACL是有效的][
  // 一个是`show ip access-list`，一个是执行`ping`命令，看是否失败
]

#cprob()[简述ACL中的 Access-list number][
  // 列张表，参考ppt
]


