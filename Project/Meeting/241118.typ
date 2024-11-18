#import "../../template.typ": *

#let title = "组会1 会议议题&纪要"
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
- 评分
- 评论
- ……？

== 在线阅读器

- 阅读
- 样式变化
- 章节跳转
- ……？

== 限定

- 前端页面：仅需考虑手机竖屏的尺寸
- 前端框架：基于React
- 后端接口：以`RESTful API`为规范
- 正文内容储存基于OSS

= 建议

- 团队内部加强沟通，若有困难及时在群里反馈
- 人员分工：外科手术式的分工，经验丰富的人负责主体实现，另一个人打下手辅助
