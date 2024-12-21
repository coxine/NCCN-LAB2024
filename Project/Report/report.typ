#import "../../template.typ": *

#let title = "小组大作业报告"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = ""
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 应用简介

我们小组的大作业是一个基于微信小程序的在线阅读器与书籍评价系统*“流风读书”*，我们参考了豆瓣读书等同类型的软件进行开发。


= 主要功能点

== 首页

== 书籍收藏

== 书籍搜索

== 书籍介绍

== 书评撰写

== 在线阅读器

== 用户中心

= 前端实现

= 后端实现

#pagebreak()

= 部署与运维


本项目前后端分离，前后端通过RESTful API进行通信，具体架构详见下图。

#align(
  center,
  image("strucutre.svg", height: 80%, alt: "架构图"),
)



== 前端


前端代码通过微信开发者工具内置的上传功能，上传并部署于微信服务器上。前端通过云函数转发请求至后端。

== 后端

后端代码部署在*AWS*上的 *Elastic Compute Cloud* 服务器上，通过*Nginx*进行反向代理。

后端服务使用域名`read-back.cos.tg`，通过*Cloudflare*配置DNS和CDN，流量经过Cloudflare代理，使用Cloudflare签发的证书进行SSL加密。

== SQL

SQL服务部署在*AWS*上的 *Elastic Compute Cloud* 服务器上。

== CI/CD

后端利用*GitHub Actions*在每次commit后，在Github的服务器上进行打包，并将新版本的包通过`ssh` 和 `scp` 传输至服务器，完成CI/CD。

= 遇到的问题

#cprob()[
  服务器宕机频率高
][
  通过排查Cloudflare、Nginx、SpringBoot的日志，发现是大量恶意请求和服务器的内存瓶颈导致的，通过

  - 配置Cloudflare的防火墙和异常拦截
  - 在Nginx上限制非Cloudflare请求
  - 扩大服务器的Swap分区

  解决了这个问题。
]

= 项目总结


