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

#align(center)[
  #image("img/main.png", height: 40%, alt: "首页")
]


首页展示了所有书籍的标题、tag、评分、封面。在此页面中，用户可：根据书籍标题进行书籍搜索；点击进入书籍详细页面；收藏/取消收藏书籍。

== 个人书架

#align(center)[
  #image("img/favorite.png", height: 40%, alt: "个人书架")
]

个人书架展示了用户已收藏的书籍。在该页面，用户也可以根据书籍标题进行搜索，或是取消收藏书籍。被取消收藏的书籍将不会展示在该页面。


== 书籍详情

#align(center)[
  #image("img/bookdetail.png", height: 40%, alt: "书籍详情")
]

书籍详细展示了书籍的标题、作者、封面、tag、评分、简介等信息。用户也可以在该页面中对书籍进行收藏或取消收藏。用户可以点击对应章节进入阅读器进行阅读。

详情界面还增加了书评功能。用户可查看他人的书评，也可以通过“添加评论”进行评论。

== 在线阅读器

#align(center)[
  #image("img/reader.png", height: 40%, alt: "在线阅读器")
]

用户可在阅读器中阅读书籍正文。用户也可通过标题旁的“上一章”和“下一章”的按钮进行上下章节的跳转。

== 个人主页

#align(center)[
  #image("img/homepage.png", height: 40%, alt: "个人主页")
]

个人主页展示了用户的用户名以及个人签名。用户可以在“修改个人信息”一栏进行用户名和个人签名的修改。同时用户也可以点击“致谢”和“应用信息”查看相关信息。

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

后端服务使用域名#link("https://read-back.cos.tg")，通过*Cloudflare*配置DNS和CDN，流量经过Cloudflare代理，使用Cloudflare签发的证书进行SSL加密。

== SQL

SQL服务部署在*AWS*上的 *Elastic Compute Cloud* 服务器上。

== CI/CD

后端利用*GitHub Actions*在每次commit后，在Github的服务器上进行打包，并将新版本的包通过`ssh` 和 `scp` 传输至服务器，完成CI/CD。

= 项目亮点

== 前端设计层次化

在页面的设计上，我们从用户体验需求出发，打破统一白色背景的传统，采用“阴阳”不同背景以凸显书籍信息和评论区，并在不同的功能区使用不同的色差进行区分，降低用户审美疲劳。

== CI/CD自动化部署

我们使用GitHub Actions进行CI/CD。每次commit后，GitHub Actions会自动打包并传输新版本的包至服务器，实现了自动化部署。此外，我们设置了自动脚本，在服务器宕机后，会自动重启服务器并拉起服务，保证了服务的稳定性。

= 遇到的问题

#cprob()[
  无法访问未备案域名
][
  微信原生的`wx.request`方法存在限制，无法成功访问未备案的后端域名。在查阅了相关资料和社区中其他开发者的提议后，我们使用微信的云函数功能，通过建立能够模拟`GET`和`POST`功能的云函数作为中转，从而绕开域名限制，成功访问了未备案的后端域名。
]

#cprob()[
  服务器宕机频率高
][
  通过排查Cloudflare、Nginx、SpringBoot的日志，发现大量恶意请求和服务器的内存瓶颈导致了CPU占用100%后宕机，通过

  - 配置Cloudflare的防火墙和异常拦截
  - 在Nginx上限制非Cloudflare请求
  - 扩大服务器的Swap分区

  解决了这个问题。
  在完成以上操作后，服务器平稳运行，没有再出现宕机的情况。
]

= 项目总结


