# ExPress — LaTeX 书籍文档类

**一次配置，生成专业排版的书籍 PDF。**

ExPress 是一个专为书籍排版设计的 LaTeX 文档类，延续了 ExBook 的极简配置理念，同时新增了书籍特有的结构：篇/章/节、前言、附录、参考文献和边注。

---

## 功能特点

1. **现代极简封面**：侧面色块 + 大字标题，配色随 12 种主题色自动切换
2. **完整书籍结构**：篇（Part）/ 章（Chapter）/ 节（Section）三级层次
3. **保留全部习题功能**：题目组、选择题自动排版、解析环境、小问列表
4. **前言 / 附录 / 参考文献**：开箱即用的书籍结构环境
5. **边注（可选）**：一键开关，关闭时自动回退为脚注
6. **图/表按章编号**：主题色题注，格式 "Fig 2.1"
7. **页眉章节名随动**：偶数页章名，奇数页节名
8. **深色模式**：全局暗色主题
9. **支持 A4 / B5**：文档类选项一键切换
10. **12 种颜色主题**：4 种经典 + 8 种 MBTI 个性色

---

## 快速开始

```bash
# 编译示例
latexmk main.tex

# 或直接使用 xelatex
xelatex main.tex

# 清理辅助文件
latexmk -c
```

---

## 文档类选项

| 选项 | 默认 | 说明 |
|------|------|------|
| `a4paper` / `b5paper` | a4paper | 纸张尺寸 |
| `adobe` / `ubuntu` / `mac` / `windows` / `fandol` | fandol | 中文字体集 |
| `printmode` | false | 双面打印 + 装订边距 |
| `online` | false | 封面显示勘误链接 |
| `water` | false | 每页右下角水印 |
| `darkmode` | false | 深色模式 |
| `notocnum` | false | 隐藏章节编号 |
| `showmark` | false | 页眉自动显示章节名 |
| `analysis` | false | 全局显示习题解析 |
| `marginnotes` | false | 启用边注 |

使用示例：

```latex
\documentclass[showmark, analysis, marginnotes]{ExPress}
```

---

## 配置说明

所有配置在 `config.tex` 中完成，无需编辑类文件。

### 封面设置

```latex
\CoverImg{}                          % 留空使用纯色块；填入路径使用封面图
\PreTitle{EXPRESS · BOOK TEMPLATE}   % 前置标题
\Title{数据科学导论}                   % 主标题
\Subtitle{从理论到实践}                % 副标题
\Author{张三 · 李四}                  % 作者
\Motto{行稳致远，厚积薄发}             % 座右铭
\UpdateTime{2026.05}                  % 日期
\OnlineCheckUrl{https://...}          % 勘误地址（online 选项开启时显示）
```

### 主题颜色

```latex
% 经典色：\blue（默认） \green \purple \orange
% MBTI 色：\infj \enfp \infp \esfp \intj \entp \isfj \enfj
\setThemeColor{\blue}
```

### 其他设置

```latex
% 答案显示：\showSolution / \hideSolution
\setSolutionDisplay{\hideSolution}

% 边注开关：on / off
\marginnotetoggle{off}

% 水印
\TextWater{[水印文字]}
\WaterImg{img/water.png}
```

---

## 环境与命令

### 书籍结构

| 环境 | 说明 |
|------|------|
| `preface` | 前言（无编号章节 + 加入目录） |
| `appendices` | 附录（章号重置为 A, B, C...） |
| `references` | 参考文献（thebibliography 包装） |

### 习题系统

```latex
\begin{qitems}[选项]
    \begin{bbox}
        \qitem 题目内容
        \fourchoices{选项A}{选项B}{选项C}{选项D}
        \begin{analysis}[前缀]
            解析内容
        \end{analysis}
    \end{bbox}
\end{qitems}
```

**qitems 环境选项**：

| 键 | 默认值 | 说明 |
|------|------|------|
| `unreset` | — | 不重置题号 |
| `unshow` | — | 隐藏题号 |
| `showanalysis` | — | 显示解析 |
| `prefix` | （空） | 题号前缀 |
| `suffix` | `.` | 题号后缀 |
| `optprefix` | （空） | 选项标签前缀 |
| `optsuffix` | `.` | 选项标签后缀 |
| `startnum` | `0` | 起始题号 |

**选择题选项命令**：

```latex
\threechoices{A}{B}{C}              % 三个选项（自动排版）
\fourchoices{A}{B}{C}{D}            % 四个选项
\fivechoices{A}{B}{C}{D}{E}         % 五个选项
\sixchoices{A}{B}{C}{D}{E}{F}       % 六个选项
```

选项会根据文字长度自动排列为 1 列、2 列或 4 列。

**小问环境**：

```latex
\begin{subqitems}
    \subqitem 第一小问
    \subqitem 第二小问
\end{subqitems}
```

### 工具命令

| 命令 | 说明 |
|------|------|
| `\imgin[缩放]{对齐}{路径}` | 插入图片（对齐：l=左，r=右，空=居中） |
| `\autotilte[对齐]{标题}{副标题}` | 自由标题 |
| `\blankbox` / `\eblankbox` | 中文/英文空括号 |
| `\blankline` | 空白下划线 |
| `\qanswerloc{页码}` | 答案位置指示 |
| `\textwater` | 渲染水印文字 |
| `\mynote{内容}` | 边注（开启时显示在页边，关闭时变脚注） |
| `\noreftitle{标题}` | 无索引标题 |
| `\hideheaderfooter` | 隐藏当前页页眉页脚 |

### 代码高亮

```latex
\begin{lstlisting}
int main() {
    return 0;
}
\end{lstlisting}
```

### 图/表题注

图/表按章自动编号，题注标签使用主题色：

```latex
\begin{figure}[htbp]
    \centering
    \imgin{}{fig/example.png}
    \caption{图释文字}
    \label{fig:example}
\end{figure}
```

---

## 文档结构示例

```
main.tex                  # 主文档入口
├── config.tex            # 用户配置
├── \maketitle            # 封面
├── preface               # 前言
├── \tableofcontents      # 目录
├── \part{第一部分}        # 篇
│   ├── \chapter{第一章}   # 章
│   │   ├── \section{...}  # 节（理论内容）
│   │   └── \section{...}  # 节（习题）
├── appendices            # 附录
│   └── \chapter{附录 A}
└── references            # 参考文献
```

---

## 项目结构

```
ExPress/
├── ExPress.cls            # 类文件（1096 行，清晰分段）
├── config.tex             # 用户配置
├── .latexmkrc             # 编译配置
├── README.md              # 本文档
├── main.tex               # 示例主文档
├── example/
│   └── chapters/
│       ├── ch01.tex       # 理论章：算法基础
│       ├── ch01-ex.tex    # 习题章：算法基础习题
│       ├── ch02.tex       # 理论章：数据结构
│       ├── ch02-ex.tex    # 习题章：数据结构习题
│       └── appendix.tex   # 附录：公式 + 参考答案
├── img/
│   ├── cover.jpg          # 封面图片（可选）
│   └── water.png          # 水印图片
└── fig/                   # 正文插图
```

---

## 许可证

MIT License