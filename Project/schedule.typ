#import "../template.typ": *

#let title = "时间安排"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = ""
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 组会议题

== 2024-11-18

- 确定具体的功能
- 确定前端页面
- 确定后端接口
- 确定时间安排

== 2024-11-25

- 前端页面定稿
- 前端组&后端组协商接口的具体实现方式
- 确定需要额外使用的云服务
- Code Review 问题整改

== 2024-12-02

- 验收前端页面
- 验收后端接口
- 前后端联调协商
- Code Review 问题整改
- 项目部署相关

= 开发计划

== 11/18-11/24

=== 前端

#table(
  columns: (60%, 8%, 22%, 10%),
  align: (left, center, center, center),
  table.header[*任务*][*DDL*][*呈现形式*][*完成*],
  [根据组会确定具体页面数量、画出页面草图], [11/24], [发群], [✔],
  [调研并确定使用的框架、配置环境], [11/25], [ 组会上说明], [✔],
)

=== 后端

#table(
  columns: (60%, 8%, 22%, 10%),
  align: (left, center, center, center),
  table.header[*任务*][*DDL*][*呈现形式*][*完成*],
  [根据组会确定接口、初步撰写接口文档], [11/24], [传repo], [✔],
  [了解OSS & 微信登陆], [11/25], [组会上说明], [✔],
  [调研并确定使用的框架、配置环境], [11/25], [ 组会上说明], [✔],
)

=== 统筹

#table(
  columns: (60%, 8%, 22%, 10%),
  align: (left, center, center, center),
  table.header[*任务*][*DDL*][*呈现形式*][*完成*],
  [配置前后端仓库], [11/20], [将链接发群], [✔],
  [确定项目的部署方式、完成自动化部署], [11/25], [组会上说明], [✔],
)

== 11/25-12/1

=== 前端

#table(
  columns: (60%, 8%, 22%, 10%),
  align: (left, center, center, center),
  table.header[*任务*][*DDL*][*呈现形式*][*完成*],
  [和后端对接 确认接口详细信息], [实时], [发群], [-],
  [根据组会和#link("ed.cos.tg")[后端接口]确定具体页面数量、画出页面草图], [11/27], [发群], [✔],
  [完成页面布局、交互], [12/1], [commit 前端仓库], [],
)

=== 后端

#table(
  columns: (60%, 8%, 22%, 10%),
  align: (left, center, center, center),
  table.header[*任务*][*DDL*][*呈现形式*][*完成*],
  [和前端对接 确认接口详细信息], [实时], [发群], [-],
  [完善文档], [实时], [commit 后端仓库], [],
  [完成接口的具体实现], [12/1], [commit 后端仓库], [],
)

=== 统筹

#table(
  columns: (60%, 8%, 22%, 10%),
  align: (left, center, center, center),
  table.header[*任务*][*DDL*][*呈现形式*][*完成*],
  [协助后端测试接口], [实时], [], [-],
  [后端文档 Review], [11/25], [commit 后端仓库], [✔],
  [文档站样式调整], [11/26], [commit 后端仓库], [✔],
  [Git 文档], [11/26], [commit 后端仓库], [✔],
  [后端文档代码自动格式化], [11/26], [commit 后端仓库], [✔],
  [前端其他分支预览], [11/27], [commit 前端仓库], [无需],
  [SQL环境配置], [11/29], [服务器部署], [✔],
  [CI/CD], [12/1], [服务器部署], [],
  [Code review], [12/1], [发群], [],
)

== 12/2-12/8

=== 前端

#table(
  columns: (60%, 8%, 22%, 10%),
  align: (left, center, center, center),
  table.header[*任务*][*DDL*][*呈现形式*][*完成*],
  [完成页面布局、交互], [12/8], [commit 前端仓库], [],
  [完成`POST`请求测试], [12/8], [commit 前端仓库], [],
  [完成前后端联调], [12/8], [], [],
)


=== 后端

#table(
  columns: (60%, 8%, 22%, 10%),
  align: (left, center, center, center),
  table.header[*任务*][*DDL*][*呈现形式*][*完成*],
  [完善文档], [实时], [commit 后端仓库], [],
  [跑通打包构建流程], [12/3], [commit 后端仓库], [],
  [完成接口的具体实现], [12/8], [commit 后端仓库], [],
  [完成前后端联调], [12/8], [], [],
)

=== 统筹

#table(
  columns: (60%, 8%, 22%, 10%),
  align: (left, center, center, center),
  table.header[*任务*][*DDL*][*呈现形式*][*完成*],
  [CI/CD], [12/8], [服务器部署], [],
  [Code review], [12/8], [发群], [],
  [测试全部功能], [12/8], [], [],
)


== 12/9-12/15

- 机动时间，处理可能出现的问题