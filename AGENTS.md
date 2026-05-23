# AGENTS.md — ExPress

## 项目概述

ExPress 是一个面向书籍排版的 LaTeX 文档类（`.cls`）。基于 `book` 基类，提供篇/章/节完整结构，以及前言、附录、参考文献环境。支持 A4/B5，12 色主题，边注系统，且完全兼容 ExBookie 的习题命令。

## 文件结构

```
ExPress/
├── ExPress.cls              # 文档类文件（核心）
├── config.tex               # 用户配置文件
├── .latexmkrc               # latexmk 编译配置
├── main.tex                 # 示例主文档入口
├── main.pdf                 # 编译结果预览
├── example/
│   └── chapters/
│       ├── ch01.tex         # 理论章示例
│       ├── ch01-ex.tex      # 习题章示例
│       ├── ch02.tex
│       ├── ch02-ex.tex
│       └── appendix.tex     # 附录示例
├── img/                     # 封面图、水印图
└── fig/                     # 正文插图
```

## 文档类选项

调用方式：`\documentclass[选项1, 选项2]{ExPress}`

| 类别 | 选项 | 说明 |
|------|------|------|
| 纸张 | `a4paper`（默认）, `b5paper` | 纸张尺寸 |
| 字体 | `fandol`（推荐）, `adobe`, `ubuntu`, `windows`, `mac` | 中文字体集 |
| 功能 | `darkmode`, `printmode`, `water`, `online`, `analysis`, `notocnum`, `showmark`, `marginnotes` | 深色模式、打印、水印、边注等 |

## 书籍结构

```latex
\part{篇名}           % 第一部分
\chapter{章名}        % 第一章
\section{节名}        % 第一节
\subsection{子节名}   % 第一小节
```

### 特殊环境
- `\begin{preface} ... \end{preface}` — 前言（无编号章节，加入目录）
- `\begin{appendices} ... \end{appendices}` — 附录（章号重置为 A, B, C...）
- `\begin{references} ... \end{references}` — 参考文献

## 封面配置（config.tex）

```latex
\CoverImg{}                          % 留空=纯色块封面；填入路径=使用封面图
\PreTitle{EXPRESS · BOOK TEMPLATE}   % 前置标题
\Title{数据科学导论}                   % 主标题
\Subtitle{从理论到实践}                % 副标题
\Author{张三 · 李四}                  % 作者
\Motto{行稳致远，厚积薄发}             % 座右铭
\UpdateTime{2026.05}                  % 日期
```

封面为左侧 38% 宽主题色竖条 + 右侧稿纸区风格。

## 习题系统

完全兼容 ExBookie 的全部习题命令：
- `qitems` 题组环境、`bbox` 题目容器、`\qitem` 题目
- `\threechoices` ~ `\sixchoices` 选择题
- `analysis` 解析环境、`subqitems` 小问环境

## 其他功能

- **边注**：`\mynote{内容}`，由 `marginnotes` 选项控制，关闭时自动回退为脚注
- **图表题注**：`\caption{...}`，按章自动编号（Fig 2.1），标签使用主题色
- **代码高亮**：`lstlisting` 环境
- **页眉随动**：`showmark` 选项，偶数页显章名，奇数页显节名
- **答案控制**：`\setSolutionDisplay{\hideSolution}` / `\showSolution`

## 编译

```bash
latexmk main.tex    # 编译
latexmk -c          # 清理
```

## AI 辅助用户的常见任务

1. **帮用户搭建书籍结构** — 创建篇/章/节的 tex 文件框架
2. **配置封面和样式** — 编辑 config.tex 设置标题、作者、主题色
3. **录入习题** — 将题目转换为 qitems/bbox 格式（与 ExBookie 通用）
4. **切换纸张尺寸** — A4 ↔ B5，封面和边距自动适配
5. **管理参考文献和附录** — 使用 references 和 appendices 环境
