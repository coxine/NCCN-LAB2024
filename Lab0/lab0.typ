#import "template.typ": *

#let title = "基础操作速查"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = "2024-10-28"
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 路由器

== 硬件接口

- 连接电脑显示终端内容：正面`Console`口，浅蓝色线连接
- 路由器间连接：背面`s0/1/0`口(左)，`s0/1/1`口（右）蓝色线连接
- 路由器与电脑连接：`g0/0/0`口

== 基本操作


```
Router> enable # 进入特权模式
Router# configure terminal # 进入全局配置模式

# 修改路由器名
Router(config)# hostname \<name\>

# 进入控制台配置模式
Router(config)#line con 0
Router(config-line)#logging synchronous

# 关闭浪费时间的域名解析
Router(config)#no ip domain-lookup
```

== 配置IP

```
Router(config)# interface s0/1/0 # 进入接口配置模式
Router(config-if)# ip address \<ip\> \<mask\> # 配置接口IP地址
Router(config-if)# no shutdown # 开启接口
Router(config-if)# exit # 退出接口配置模式
```

== 配置路由

```
# 静态路由
Router(config)# ip route \<dst\> \<mask\> \<next-hop\>
# 删除路由
Router(config)# no ip route \<dst\> \<mask\> \<next-hop\>
# 默认路由
Router(config)# ip route 0.0.0.0 0.0.0.0 \<next-hop\>
# 动态路由
Router(config)# router rip
Router(config-router)# network \<network\>
Router(config-router)# exit
# 显示路由表
Router# show ip route
```
