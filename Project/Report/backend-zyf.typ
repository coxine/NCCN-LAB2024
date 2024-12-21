#import "../../template.typ": *

#let title = "小组大作业 后端部分报告"
#let author = "第7组"
#let course_id = "互联网计算"
#let instructor = "刘峰老师"
#let semester = "2024 秋季学期"
#let due_time = ""
#let id = "华振翔 林桂超 王涵 张家浩 张屹峰"

#show: assignment_class.with(title, author, course_id, instructor, semester, due_time, id)

= 建议角度

- 框架选择
  使用了Spring Boot框架。
- 后端实现
- 接口
  - 用户相关
    - 获取当前登录信息的用户信息
      - URL: `$(URL)/user/profile`
      - 类型: `POST`
      - 若成功, Return Value中的data字段:
          ```
          {
            id: number
            nickname: string
            intro: string
            favorite:[number, number, number ...]
          }
          ```
          - `id`, `nickname` 分别表示用户的 ID 和昵称, 其中ID是我们希望是用来唯一标识用户的属性
          - `intro` 表示用户的个人简介、自我描述.
          - `favorite` 数组表示用户的收藏列表, 每个元素表示目标书籍的 `id`
    - 已知目标用户的用户 ID 时获取用户信息
      - URL: `$(URL)/user/profile/$(id)` (注: `$(id)`为用户的 `id`)
      - 类型: `GET`
      - 若成功, Return Value中的data字段:
          ```
          {
            id: number
            nickname: string
            intro: string
            favorite:[number, number, number ...]
          }
          ```
          - `id`, `nickname` 分别表示用户的 ID 和昵称, 其中ID是我们希望是用来唯一标识用户的属性
          - `intro` 表示用户的个人简介、自我描述.
          - `favorite` 数组表示用户的收藏列表, 每个元素表示目标书籍的 `id`
    - 提交用户收藏书籍请求
      - URL: `$(URL)/user/favorite`
      - 类型: `POST`
      - 请求体中的`data`属性:
          ```
          {
            id: number;
            bookID: number;
          }
          ```
          - `id`为用户的`id`
          - `bookID`为书的`id`
      - 若成功, Return Value中的data字段:`null`(仅指示是否成功)
    - 提交用户修改个人信息请求
      - URL: `$(URL)/user/update`
      - 类型: `POST`
      - 请求体类型为:
          ```
          {
            data:{id,nickname,intro}
            avatar:xxxxx
          }
          ```
       - 请求体中的`data`属性:
          ```
          {
            id: string;
            nickname: string;
            intro: string;
          }
          ```
        - `id`为用户的`id`
        - `nickname`,`intro`均为用户想修改为的信息
          - 初始值是用户原来的值
          - `intro`在100字内,`nickname`在30字内
        - `avatar`为用户的新头像
      - 若成功, Return Value中的data字段:为`null`(仅指示是否成功)
- 数据库
  使用了MySQL数据库。
- 性能
- 遇到的困难&解决方案
- ……