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

我们小组的大作业是一个基于微信小程序的在线阅读器与书籍评价系统*“流风读书”*，我们参考了豆瓣读书等同类型的软件进行开发。我们以“*流风*”为名，寓意着我们的应用能够像流风一样，带给用户清新的阅读体验。

= 前端及主要功能点

前端基于微信小程序平台，采用了 WEUI-miniprogram 作为前端UI框架。WEUI-miniprogram 是一款专为微信小程序设计的UI库，仿照了微信原生的UI设计，使得界面设计更加统一和专业。

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


= 后端接口

后端提供了一组可靠的HTTP API接口，来处理前端对应用相关数据的请求和为数据持久化保存的请求，从而为客户端提供稳定、便捷的服务。具体地，在该业务场景下提供如下功能：

+ 保存和获取书籍的相关信息，包括：
  + 全部书籍列表及概要
  + 书籍目录
  + 章节具体内容
  + 书籍封面图片
  + 书籍评论
+ 处理用户的登录和操作请求，包括：
  + 处理用户登录
  + 处理用户提交书评
  + 处理用户增加/取消收藏书籍
+ 保存和获取用户在该应用保存的的相关信息，包括：
  + 获取和修改用户信息

== 接口列表及功能

下文中出现的`$(URL)`字样均指的是后端接口地址：#link("https://read-back.cos.tg")，

该部分仅对API简单概述，更多信息请参阅#link("http://ed.cos.tg")[后端文档]。

#table(
  columns: (5%, 40%, 7%, 48%),
  align: (center, center, center, center),
  table.header[编号][*URL*][*请求类型*][*功能概述*],
  [1], [`$(URL)/book/list`], [`GET`], [获取全部书籍列表及书籍概况],
  [2], [`$(URL)/book/content/$(bookID)`], [`GET`], [获取某本书的目录],
  [3], [`$(URL)/book/chapter/$(bookID)/$(chapterID)`], [`GET`], [获取特定章节具体内容],
  [4], [`$(URL)/book/chapter/json/$(bookID)/$(chapterID)`], [`GET`], [获取特定章节具体内容，并附带章节名称],
  [5], [`$(URL)/book/cover/$(bookID)`], [`GET`], [获取书籍封面],
  [6], [`$(URL)/book/comment/$(bookID)`], [`GET`], [获取书籍评论],
  [7], [`$(URL)/user/coment`], [`POST`], [提交用户对书籍的评论],
  [8], [`$(URL)/user/profile`], [`POST`], [获取当前登录信息的用户信息],
  [9], [`$(URL)/user/profile/$(id)`], [`GET`], [已知目标用户的用户 ID 时获取用户信息],
  [10], [`$(URL)/user/avatar/$(id)`], [`GET`], [获取用户头像],
  [11], [`$(URL)/user/favorite`], [`POST`], [提交用户收藏书籍请求],
  [12], [`$(URL)/user/update`], [`POST`], [提交用户修改个人信息请求],
)


== 实现方案

后端采用JAVA Spring Boot框架 + MySQL数据库的方案。

=== 数据库操作

涉及数据库增删改查相关的API采用Spring Boot框架提供的能力得到实现，遵循如下框架：

#align(center)[
  #image("./img/ed_structure.png", height: 70%, alt: "后端架构")
]

请求来到后端，经历如下过程：
+ 先由`Controller`类进行事件分发，调用`Service`类对应的方法来处理。
+ `Service`类处理的过程中调用`Repository`类。
+ `Repository`类与数据库进行交互，将得到的数据返回给`Service`类。
+ `Service`类经过处理后返回给`Controller`类。
+ `Controller`类将数据转换成 JSON 对象返回给前端。

数据库结构请参阅#link("http://ed.cos.tg")[后端文档]。

=== 静态资源请求

图片和章节的具体内容等静态资源由`Controller`重定向到特定URL上，前端通过`GET`请求获取。同时使用Cloudflare进行CDN加速，提高访问速度，缓解服务器压力。

=== 用户登录

用户的一键登录基于微信提供的API实现。

#pagebreak()

= 部署与运维

本项目前后端分离，前后端通过RESTful API进行通信，具体架构详见下图。

#align(
  center,
  image("./img/strucutre.png", height: 80%, alt: "架构图"),
)


== 前端

前端代码通过微信开发者工具内置的上传功能，进行编译、打包并部署于微信服务器上。前端通过云函数转发请求至后端。

== 后端

后端Spring Boot服务部署在*AWS*上的 *Elastic Compute Cloud* 服务器上，通过*Nginx*进行反向代理。

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
  通过排查Cloudflare、Nginx、Spring Boot的日志，发现大量恶意请求和服务器的内存瓶颈导致了CPU占用100%后宕机，通过

  - 配置Cloudflare的防火墙和异常拦截
  - 在Nginx上限制非Cloudflare请求
  - 扩大服务器的Swap分区

  解决了这个问题。
  在完成以上操作后，服务器平稳运行，没有再出现宕机的情况。
]

= 项目总结

经过一个月的努力，我们成功开发出了一个功能完善、用户体验良好的在线阅读器与书籍评价系统。从最初的需求分析到最终的功能实现，我们在项目的开发过程中收获了许多宝贵的经验，也在解决实际问题中提升了团队协作能力和技术水平。

未来，我们会继续完善我们的应用，增加更多的社交化功能，提升用户体验，为用户提供更好的服务。优化高并发场景下的性能，提高系统的稳定性。同时，我们也会继续学习新的技术，不断提升自己的技术水平，为更多的用户提供更好的服务。

在我们开发的过程中，有很多专业的人士给予了我们很多的帮助，在此对他们表示感谢。

- 上课风趣幽默，娓娓道来的*刘峰老师*
- 每周值守在实验室，为我们答疑解惑的*助教哥哥*
- 为我们提供了免费云服务器的*AWS*
- 为我们提供了免费DNS解析与CDN服务的*Cloudflare*
- 为我们提供了优秀的前端UI框架的*WeUI*
- 为我们提供了稳定高效的解决方案的*Spring Boot*和*MySQL*
