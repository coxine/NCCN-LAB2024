#import "../../template.typ": *

#let title = "组会1"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = ""
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 功能&需求

== 书籍评价

- 基本信息
  - 作者姓名
  - Tag
  - 简介
  - 豆瓣评分
- 评论：无楼中楼、无点赞

== 书架

- 个人收藏

== 在线阅读器

- Demo: #link("https://xq.131432.xyz/erhahetadebaimaoshizun/107349.html")
- 初始进入首章
- 竖向滑动
- 阅读：纯文本
- 样式变化
  - 字体：大/中/小
  - 背景：白/黑
- 目录
- 上一章/下一章
- 章节跳转

== 用户

- 自定义昵称/头像
- 不牵涉到点进用户详细资料的需求


== 限定

- 有限的几本书
- 前端页面：仅需考虑手机竖屏的尺寸
- 前端框架：基于React
- 后端接口：以`RESTful API`为规范
- 正文内容储存基于OSS

= 前端

- 书籍评价页面
  - 评论区域
- 个人资料：书架
- 在线阅读器
  - 阅读
  - 目录
- 底部导航栏

= 接口

== 书

- `GET /book/list` 获取书籍列表 数据体是否指定请求书记得编号，若无则返回所有
- `GET /book/:id` 获取书籍详情

== 评论

- `GET /comments/` 获取书籍评论 请求体含id
- `POST /comment/` 发表评论 请求体含id

== 用户

- `GET /user/:id` 获取用户信息及收藏书籍编号（将返回的收藏书籍编号数组请求`GET /book/list`）
- `POST /user/:id` 修改用户信息 上传头像 后端进行图片的处理

== 正文

- OSS以章节为单位储存
- `GET /content/:bookID` 获取书籍目录 返回章节名称以及章节编号
- `GET /content/:bookID/:chapterID` 获取章节内容 返回章节正文的text/plain格式

= 建议

- 团队内部加强沟通，若有困难及时在群里反馈
- 人员分工：外科手术式的分工，经验丰富的人负责主体实现，另一个人打下手辅助
