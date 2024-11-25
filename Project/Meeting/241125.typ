#import "../../template.typ": *

#let title = "组会2"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = ""
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 上周任务

== 前端开发

TODO 在Week2补上进度

== 后端开发

详见文档网站

== 部署

1. 服务器已完成配置
2. SSL已完成配置
  - 流量经Cloudflare代理
  - 服务器安装Cloudflare签发的证书
3. 域名完成配置 #link("https://read-back.cos.tg/")[https://read-back.cos.tg/]

=== 前端

1. 下载 *微信开发者工具*
2. 将前端仓库`clone`到本地
3. 在微信开发者工具中导入前端仓库
4. 开发完成后先`commit`并`push`，然后在微信开发者工具中上传代码

=== 后端

1. SpringBoot后端直接运行`jar`包
2. SQL环境待配置
3. 自动化流程待配置

= 全员完成

各个仓库进行配置以减少冲突

```
git config --global merge.ff false # 禁用 fast forward
git config --global pull.rebase true # 开启 pull rebase
```