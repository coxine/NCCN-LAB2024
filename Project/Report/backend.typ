#import "../../template.typ": *

#let title = "小组大作业 后端部分报告"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = ""
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 功能概述
本后端旨在提供一组HTTP api接口，来处理前端对应用相关数据的请求和为数据持久化保存的请求，从而为客户端提供稳定、便捷的服务。

具体地，在该业务场景下提供如下功能：

+ 保存和获取书籍的相关信息，包括获取：
  + 全部书籍列表及概况
  + 书籍的目录
  + 章节的具体内容
  + 书籍的封面图片
  + 书籍的评论

+ 处理用户的登录和操作请求，包括：
  + 处理用户登录
  + 处理用户评论的提交
  + 处理用户收藏的提交

+ 保存和获取用户在该应用保存的的相关信息，包括：
  + 获取和修改用户信息


= 技术方案

== 接口列表及功能
下文中出现的`$(URL)`字样均指的是https://read-back.cos.tg

该部分仅对api做简单的概述，详情请参见我们的后端需求说明文档http://ed.cos.tg
#table(
  columns: (5%,35%, 10%, 50%),
  align: (center, center, center, center),
  table.header[编号][*URL*][*请求类型*][*功能概述*],
  [1], [\$(URL)/book/list], [GET], [获取全部书籍列表及书籍概况],
  [2], [\$(URL)/book/content/\$(bookID)], [GET], [获取某本书的目录],
  [3], [\$(URL)/book/chapter/\$(bookID)/\$(chapterID)], [GET], [获取特定章节具体内容],
  [4], [\$(URL)/book/chapter/json/\$(bookID)/\$(chapterID)], [GET], [获取特定章节具体内容，并附带章节名称],
  [5], [\$(URL)/book/cover/\$(bookID)], [GET], [获取书籍封面],
  [6], [\$(URL)/book/comment/\$(bookID)], [GET], [获取书籍评论],
  [7], [\$(URL)/user/coment], [POST], [提交用户对书籍的评论],
  [8], [\$(URL)/user/profile], [POST], [获取当前登录信息的用户信息],
  [9], [\$(URL)/user/profile/\$(id)], [GET], [已知目标用户的用户 ID 时获取用户信息],
  [10], [\$(URL)/user/avatar/\$(id)], [GET], [获取用户头像],
  [11], [\$(URL)/user/favorite], [POST], [提交用户收藏书籍请求],
  [12], [\$(URL)/user/update], [POST], [提交用户修改个人信息请求],
)


== 方案概述：
采用JAVA Spring Boot框架 + MySQL数据库的方案。

其中相当一部分api采用Spring Boot框架提供的能力很容易实现对数据库内容的CRUD,参照下文的具体实现

数据库结构详见http://ed.cos.tg

图片和章节的具体内容属于静态资源，采用OSS的方案挂载到特定URL上，前端通过GET请求获取

用户的登录和标识与微信的云端服务有关，引用微信如下形式的api，具体用法参照微信小程序开发者官方文档：
```Java
  String url = String.format("https://api.weixin.qq.com/sns/jscode2session?appid=%s&secret=%s&js_code=%s&grant_type=authorization_code", APPID, APPSECRET, code);
```
其中`APPID`和`APPSECRET`为小程序注册时小程序特有的属性，`code`为当前用户登录时由微信云端产生的标识代码

== 具体实现

对于除了访问图片的请求之外，所有接口遵循如下框架：
#align(center)[
  #image("./ed_structure.png",height:280pt, width:200pt)
]
请求来到后端，经历如下过程：
+ 先由Controller类进行事件分发，调用Service类对应的方法来处理
+ Service类处理的过程中调用Repository类
+ Repository类与数据库进行交互，将得到的数据返回给Service类
+ Service类经过处理后返回给Controller类
+ Controller类将数据转换成json对象返回给前端


图片和章节的GET请求通过Spring Boot框架提供的OSS挂载到静态URL上，由Controller分发到具体的图片资源，没有Serive类和Repository类
