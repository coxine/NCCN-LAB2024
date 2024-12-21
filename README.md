# NCCN-LAB2024

- 国立中央计网小组 实验仓库
- National Central Computer Network
- 感谢[电子实验文档网站](https://pub.ydjsir.com.cn/)

## 时间节点

- 实验前自行在Packet Tracer上模拟操作
- 每周一 1800 实验
- 每周日 1800前 commit 报告初稿及模拟文件
- 每周一 1200前 commit 报告终稿

## 规范

### 命名

- Commit Message：`Labx: yyy`，如：`Lab1: Static Router`
- 文件夹：`Labx`
- pkt文件：`labx-team7.pkt`

### 正文

- 按照已有的文档的章节、格式、内容
- 文档语法：类似Markdown
- 日期：格式为 `yyyy-mm-dd`，若日期长度不够补0（如 `2024-11-03`）
- Serial名称：使用实验室版本（类似 `s0/1/0`），并在首次出现时注明模拟器版本 `# 注：在Packet Tracer中，s0/1/1口对应的是Serial3/0`
- 指令、IP地址格式为 `行内代码`，使用\`\`包裹
- 标点使用中文标点，除提纲式的列表外，所有句子都应完整明确，结尾须加句号
- 问题使用 `cprob`包裹

```markdown
#cprob()[问题
][
  答案
]
```

## Typst 相关

- [环境](https://github.com/typst-community/typst-install)
- VSC插件
  - [Tinymist Typst](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist)
  - [Typst Companion](https://marketplace.visualstudio.com/items?itemName=CalebFiggers.typst-companion)（选装 增加部分快捷键）

## 分工

| 时间  | 主题                    | 负责人 |
| ----- | ----------------------- | ------ |
| 10/21 | Lab1 静态路由和简单组网 | 张家浩 |
| 10/28 | Lab2 动态RIP            | 张屹峰 |
| 11/4  | Lab3 配置单域OSPF       | 华振翔 |
| 11/11 | Lab5 NAT网络地址转换    | 王涵   |
| 11/18 | Lab4 VLAN间路由         | 林桂超 |
| 11/25 | Lab6 ACL                | 王涵 |
| 12/2  | Lab7 PPP                | 华振翔 |
| 12/9  | 期末实验   | 林桂超 张家浩 张屹峰 |
