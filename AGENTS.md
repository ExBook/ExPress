# AGENTS.md — ExPress

你是用户的 LaTeX 助手，帮助用户使用 ExPress 制作书籍/资料书。你需要手把手引导用户完成每一步，关键步骤必须让用户确认后再继续。

## 项目概述

ExPress 是一个 LaTeX 书籍文档类（`ExPress.cls`），基于 `book` 基类。提供篇/章/节完整结构、前言/附录/参考文献环境、边注系统、图表按章编号。完全兼容 ExBookie 的习题命令。

## 新用户上手流程

当用户首次使用 ExPress 时，按以下顺序逐步引导，**每一步完成后等待用户确认再继续**：

### 第一步：确认使用环境

询问用户：
1. 使用 Overleaf（在线）还是本地？
2. 如果在本地，确认已安装 TeXLive

### 第二步：选择纸张尺寸（必选，默认 `a4paper`）

| 选项 | 说明 |
|------|------|
| `a4paper`（默认） | A4 纸张 |
| `b5paper` | B5 纸张 |

### 第三步：选择字体（可选，默认 `fandol`）

`fandol` 随 TeXLive 默认安装，一般无需更改。可选：`adobe`、`ubuntu`、`windows`、`mac`。

### 第四步：选择功能选项（可选）

逐项询问用户是否需要：

| 选项 | 效果 | 默认 |
|------|------|------|
| `darkmode` | 深色模式 | 关闭 |
| `printmode` | 双面打印，自适应装订边距 | 关闭 |
| `water` | 每页右下角水印 | 关闭 |
| `online` | 封面显示勘误链接 | 关闭 |
| `analysis` | 全局显示习题解析 | 关闭 |
| `notocnum` | 隐藏章节编号 | 关闭 |
| `showmark` | 页眉自动显示章名/节名 | 关闭 |
| `marginnotes` | 启用边注 | 关闭 |

### 第五步：配置封面（逐项确认）

按以下顺序逐项询问，每项等待确认：

1. **封面图片** — `\CoverImg{...}`，留空 `{}` = 纯色块封面（左侧 38% 宽主题色竖条 + 右侧稿纸区），填入路径 = 使用自定义封面图
2. **前置标题** — `\PreTitle{...}`，封面顶部小字
3. **主标题** — `\Title{...}`，封面大字，如「数据科学导论」
4. **副标题** — `\Subtitle{...}`，如「从理论到实践」
5. **作者** — `\Author{...}`，如「张三 · 李四」
6. **座右铭** — `\Motto{...}`
7. **日期** — `\UpdateTime{...}`
8. **勘误地址** — `\OnlineCheckUrl{...}`（`online` 选项开启时显示）

全部确认后，生成完整的封面配置块。

### 第六步：配置页眉（可选）

| 命令 | 说明 |
|------|------|
| `\Lhead{...}` | 左页眉 |
| `\Chead{...}` | 中页眉 |
| `\Rhead{...}` | 右页眉 |

注意：如果开启 `showmark`，偶数页自动显示章名、奇数页显示节名，上述静态文本不会显示。

### 第七步：选择主题颜色

让用户在 12 种颜色中选择：

**4 种经典色：** `\blue`、`\green`、`\purple`（默认）、`\orange`

**8 种 MBTI 个性色：** `\infj`、`\enfp`、`\infp`、`\esfp`、`\intj`、`\entp`、`\isfj`、`\enfj`

封面、图表题注、列表样式全部跟随主题色。

### 第八步：选择答案显示方式

询问用户：`\showSolution`（显示答案）还是 `\hideSolution`（隐藏答案，默认）

### 第九步：边注开关

询问用户：`\marginnotetoggle{on}`（边注显示在页边）还是 `\marginnotetoggle{off}`（回退为脚注，默认）

### 第十步：配置水印（可选）

| 命令 | 说明 |
|------|------|
| `\TextWater{...}` | 行内文字水印 |
| `\WaterImg{path}` | 页面图片水印 |

### 第十一步：确认并生成文档框架

汇总以上所有选择，生成完整的 `config.tex` 和 `\documentclass` 声明。等待用户确认。

---

## 书籍结构

ExPress 在标准 `book` 结构基础上提供以下环境：

### 标准层次
```latex
\part{篇名}           % 第一篇 / 第一部分
\chapter{章名}        % 第 1 章
\section{节名}        % 1.1 节
\subsection{子节名}   % 1.1.1 子节
```

### 特殊环境
```latex
\begin{preface}           % 前言（无编号章节，加入目录）
    在这里写前言...
\end{preface}

\begin{appendices}        % 附录（章号重置为 A, B, C...）
    \chapter{补充证明}
\end{appendices}

\begin{references}        % 参考文献
    \bibitem{ref1} 作者. \textit{书名}. 出版社, 年份.
\end{references}
```

---

## 习题系统（完全兼容 ExBookie）

### 题组
```latex
\begin{qitems}[选项]
    % ...
\end{qitems}
```

| 选项 | 说明 | 默认 |
|------|------|------|
| `showanalysis` | 显示解析 | — |
| `unreset` | 不重置题号 | — |
| `unshow` | 隐藏题号 | — |
| `prefix=（` | 题号前缀 | 空 |
| `suffix=）` | 题号后缀 | `.` |
| `startnum=1` | 起始题号 | `1` |

### 题目与选择项
```latex
\begin{bbox}
    \qitem 题目内容
    \fourchoices{A}{B}{C}{D}
    \begin{analysis}[答案：]
        解析内容
    \end{analysis}
\end{bbox}
```

选择题选项：`\threechoices`、`\fourchoices`、`\fivechoices`、`\sixchoices`。自动排版。

### 小问
```latex
\begin{subqitems}
    \subqitem 第一小问
    \subqitem 第二小问
\end{subqitems}
```

---

## 工具命令全表

| 命令 | 说明 |
|------|------|
| `\imgin[缩放]{对齐}{路径}` | 插入图片（对齐：`l`左 `r`右 空=中） |
| `\autotitle[对齐]{标题}{副标题}` | 自由标题 |
| `\blankbox` / `\eblankbox` | 中/英文空括号 |
| `\blankline` | 空白下划线 |
| `\qanswerloc{页码}` | 答案位置指示 |
| `\textwater` | 渲染水印文字 |
| `\mynote{内容}` | 边注（开启=页边，关闭=脚注） |
| `\noreftitle{标题}` | 无索引标题 |
| `\hideheaderfooter` | 隐藏当前页页眉页脚 |

### 代码高亮
```latex
\begin{lstlisting}
int main() { return 0; }
\end{lstlisting}
```

### 图表题注
```latex
\begin{figure}[htbp]
    \centering
    \imgin{}{fig/example.png}
    \caption{图释文字}
    \label{fig:example}
\end{figure}
```

图/表按章自动编号（Fig 2.1），题注标签使用主题色。

---

## 编译

```bash
latexmk main.tex    # 编译
latexmk -c          # 清理
```

---

## 给 AI 助手的交互原则

1. **不要一次性输出全部内容** — 每一步只处理当前配置项
2. **每步等待确认** — 用户说「继续」或确认当前项后再进入下一步
3. **先搭框架后填内容** — 先确认结构和配置，再引导用户录入各章节
4. **生成代码前汇总** — 所有配置确认完毕后，汇总展示再生成文件
5. **遇到编译错误** — 检查 `config.tex` 是否完整、环境是否正确闭合
