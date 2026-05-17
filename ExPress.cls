\def\fileversion{1.0}
\def\filedate{2026/05/17}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ExPress}[\filedate\space Version \fileversion\space by MA WEI JIAN]

% ============================================================
% ExPress —— 书籍 LaTeX 文档类
%
% 核心理念：专为书籍排版设计的单一精品布局，保留练习
% 题系统，新增篇章结构、前言/附录/参考文献、边注等功能。
%
% 用户通过 config.tex 配置（\XXX{...} 模式），无需修改类文件。
% ============================================================

% ============================================================
% Section 2 : 文档类选项
% ============================================================

% --- 纸张尺寸 ---
\newcommand\@papersize{a4paper}
\DeclareOption{a4paper}{\def\@papersize{a4paper}}
\DeclareOption{b5paper}{\def\@papersize{b5paper}}

% --- 字体集 ---
\newcommand\@fontset{fandol}
\DeclareOption{adobe}{\renewcommand\@fontset{adobe}}
\DeclareOption{ubuntu}{\renewcommand\@fontset{ubuntu}}
\DeclareOption{mac}{\renewcommand\@fontset{mac}}
\DeclareOption{windows}{\renewcommand\@fontset{windows}}
\DeclareOption{fandol}{\renewcommand\@fontset{fandol}}

% --- 布尔选项 ---
\newif\if@printmode  \@printmodefalse
\DeclareOption{printmode}{\@printmodetrue}

\newif\if@online  \@onlinefalse
\DeclareOption{online}{\@onlinetrue}

\newif\if@water  \@waterfalse
\DeclareOption{water}{\@watertrue}

\newif\if@darkmode  \@darkmodefalse
\DeclareOption{darkmode}{\@darkmodetrue}

\newif\if@notocnum  \@notocnumfalse
\DeclareOption{notocnum}{\@notocnumtrue}

\newif\if@showmark  \@showmarkfalse
\DeclareOption{showmark}{\@showmarktrue}

\newif\if@enableSolution  \@enableSolutionfalse

\newif\if@showanalysis  \@showanalysisfalse
\DeclareOption{analysis}{\@showanalysistrue}

\newif\if@marginnotes  \@marginnotesfalse
\DeclareOption{marginnotes}{\@marginnotestrue}

% --- 处理选项 ---
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

% ============================================================
% Section 3 : 加载基类与宏包
% ============================================================
\LoadClass[11pt,\@papersize]{book}

% 中文排版
\RequirePackage[fontset=\@fontset, punct=kaiming, zihao=-4]{ctex}

% 页面布局
\RequirePackage{geometry,fancyhdr}

% 颜色与图形
\RequirePackage{xcolor,graphicx,caption}

% 绘图
\RequirePackage{tikz}
\usetikzlibrary{fadings}
\usetikzlibrary{shapes,positioning}

% 彩色盒子
\RequirePackage{tcolorbox}
\tcbuselibrary{breakable}
\tcbuselibrary{skins}

% 环境定义
\RequirePackage{environ}

% 键值选项（用于 qitems 环境）
\RequirePackage{xkeyval}

% 列表定制
\RequirePackage{enumitem}

% 代码高亮
\RequirePackage{listings}

% 标题与目录
\RequirePackage{titletoc}
\RequirePackage{titlesec}

% 数学
\RequirePackage{amsmath,amssymb}
\RequirePackage{bm}

% 表格
\RequirePackage{tabularx,ifthen}
\RequirePackage{multicol}

% 符号与字体
\RequirePackage{pifont,bbding,romannum}
\RequirePackage{zhnumber}
\RequirePackage{fontspec}
\RequirePackage{fourier}

% 工具
\RequirePackage{etoolbox}
\RequirePackage{hyperref}
\RequirePackage{afterpage}
\RequirePackage{lastpage}
\RequirePackage{titling}
\RequirePackage{adjustbox}
\RequirePackage{fontawesome5}
\RequirePackage{pgffor}
\RequirePackage{pgfmath}
\RequirePackage{truncate}

% 边注
\RequirePackage{marginnote}

% ============================================================
% 中文排版设置
% ============================================================
\punctstyle{quanjiao}
\ctexset{linestretch=4, autoindent=0pt}
\setmainfont{Times New Roman}
\renewcommand\arraystretch{1.3}
\renewcommand{\baselinestretch}{1.3}

% ============================================================
% Section 4 : 深色模式基础设置
% ============================================================
\definecolor{bg}{HTML}{212121}

\if@darkmode
    \hypersetup{colorlinks=true, linkcolor=white, urlcolor=white!61.8, citecolor=white!61.8}
\else
    \hypersetup{colorlinks=true, linkcolor=black, urlcolor=themeColor, citecolor=red}
\fi

\if@darkmode
    \lstset{
        language=C,
        breaklines=true,
        basicstyle=\ttfamily,
        backgroundcolor=\color{bg!61.8},
        frame=none,
        showspaces=false,
        showstringspaces=false,
        escapeinside={(*@}{@*)}
    }
\else
    \lstset{
        language=C,
        breaklines=true,
        basicstyle=\ttfamily,
        backgroundcolor=\color{themeColor!6.2},
        showspaces=false,
        showstringspaces=false,
        escapeinside={(*@}{@*)}
    }
\fi

% ============================================================
% Section 5 : 主题颜色系统
% ============================================================

% 颜色名别名（用户通过 \setThemeColor{\blue} 引用）
\newcommand{\blue}{blue}
\newcommand{\green}{green}
\newcommand{\purple}{purple}
\newcommand{\orange}{orange}

\newcommand{\infj}{infj}
\newcommand{\enfp}{enfp}
\newcommand{\infp}{infp}
\newcommand{\esfp}{esfp}
\newcommand{\intj}{intj}
\newcommand{\entp}{entp}
\newcommand{\isfj}{isfj}
\newcommand{\enfj}{enfj}

% 颜色查表：\themeColor@NAME → HTML 值
\def\themeColor@blue{015697}
\def\themeColor@green{01847c}
\def\themeColor@purple{61589b}
\def\themeColor@orange{EA4C0E}
\def\themeColor@infj{3b4676}
\def\themeColor@enfp{d58a05}
\def\themeColor@infp{3b6079}
\def\themeColor@esfp{d86b09}
\def\themeColor@intj{38558f}
\def\themeColor@entp{8c2b2b}
\def\themeColor@isfj{4d417e}
\def\themeColor@enfj{e15715}

% 设置主题颜色（查表法，默认蓝色）
\newcommand{\setThemeColor}[1]{%
    \ifcsname themeColor@#1\endcsname
        \definecolor{themeColor}{HTML}{\csname themeColor@#1\endcsname}%
    \else
        \definecolor{themeColor}{HTML}{015697}%
    \fi
}

% 答案显示开关（必须在 \setSolutionDisplay 之前定义）
\newcommand{\showSolution}{showSolution}
\newcommand{\hideSolution}{hideSolution}

\newcommand{\setSolutionDisplay}[1]{%
    \ifx#1\showSolution
        \@enableSolutiontrue
    \else
        \ifx#1\hideSolution
            \@enableSolutionfalse
        \else
            \@enableSolutionfalse
        \fi
    \fi
}

% 应用默认值（用户可在 config.tex 中覆盖）
\setThemeColor{\blue}
\setSolutionDisplay{\hideSolution}

% ============================================================
% Section 6 : 页面几何
% ============================================================
\if@printmode
    \geometry{
        \@papersize,
        twoside,
        inner=0.12\paperwidth,
        outer=0.095\paperwidth,
        top=25mm,
        bottom=25mm,
        headsep=5mm,
        bindingoffset=8mm
    }
\else
    \geometry{
        \@papersize,
        inner=0.12\paperwidth,
        outer=0.095\paperwidth,
        top=25mm,
        bottom=25mm,
        headsep=5mm
    }
\fi

% ============================================================
% Section 7 : 用户配置项存储
%
% 每个 \ExPress@value@XXX 存储默认值，用户在 config.tex
% 中通过 \XXX{...} 覆写。存值命令与渲染命令分离。
% ============================================================

% --- 封面 ---
\def\ExPress@value@PreTitle{\textbf{ExPress · Book Template}}
\def\ExPress@value@Title{\heiti 主标题}
\def\ExPress@value@Subtitle{\textbf{副标题}}
\def\ExPress@value@Author{\textbf{作者姓名}}
\def\ExPress@value@Motto{\kaishu "行稳致远，厚积薄发。"}
\def\ExPress@value@CoverImg{}
\def\ExPress@value@UpdateTime{\textbf{最后更新：\today}}
\def\ExPress@value@OnlineCheckUrl{https://github.com/ExPress/ExPress}

% --- 页眉（showmark 关闭时使用静态文本）---
\def\ExPress@value@Lhead{左侧页眉}
\def\ExPress@value@Chead{中间页眉}
\def\ExPress@value@Rhead{右侧页眉}

% --- 水印 ---
\def\ExPress@value@TextWater{\textcolor{black!38}{\selectfont [水印文字]}}
\def\ExPress@value@WaterImg{img/water.png}

% --- 封面设置命令 ---
\newcommand\PreTitle[1]{\def\ExPress@value@PreTitle{\textbf{#1}}}
\newcommand\Title[1]{\def\ExPress@value@Title{\heiti \textbf{#1}}}
\newcommand\Subtitle[1]{\def\ExPress@value@Subtitle{\textbf{#1}}}
\newcommand\Author[1]{\def\ExPress@value@Author{\textbf{#1}}}
\newcommand\Motto[1]{\def\ExPress@value@Motto{\kaishu "#1"}}
\newcommand\CoverImg[1]{\def\ExPress@value@CoverImg{#1}}
\newcommand\UpdateTime[1]{\def\ExPress@value@UpdateTime{\textbf{最后更新：#1}}}
\newcommand\OnlineCheckUrl[1]{\def\ExPress@value@OnlineCheckUrl{#1}}

% --- 页眉设置命令 ---
\newcommand\Lhead[1]{\def\ExPress@value@Lhead{\textbf{#1}}}
\newcommand\Chead[1]{\def\ExPress@value@Chead{\textbf{#1}}}
\newcommand\Rhead[1]{\def\ExPress@value@Rhead{\textbf{#1}}}

% --- 水印设置命令 ---
\newcommand\TextWater[1]{\def\ExPress@value@TextWater{\textcolor{black!38}{\selectfont #1}}}
\newcommand{\textwater}{\ExPress@value@TextWater}  % 渲染（区别于 \TextWater 设置）
\newcommand\WaterImg[1]{\def\ExPress@value@WaterImg{#1}}

% 在线勘误链接渲染
\newcommand{\onlinecheckurl}{\ExPress@value@OnlineCheckUrl}

% ============================================================
% Section 8 : 工具命令
% ============================================================

% 答案位置指示
\if@darkmode
    \newcommand{\qanswerloc}[1]{\textcolor{white!61.8}{\selectfont \ding{226} 此部分答案见原书P#1}}
\else
    \newcommand{\qanswerloc}[1]{\textcolor{themeColor}{\selectfont \ding{226} 此部分答案见原书P#1}}
\fi

\newcommand{\blankbox}{（\hspace{1.5em}）}
\newcommand{\eblankbox}{(\hspace{1.5em})}
\newcommand{\blankline}{\underline{\hspace{3em}}}
\newcommand{\noreftitle}[1]{\par \textbf{#1} \par}

% 隐藏当前页页眉页脚
\newcommand{\hideheaderfooter}{%
    \fancypagestyle{emptyheaderfooter}{\fancyhf{}}%
    \thispagestyle{emptyheaderfooter}%
}

% 插图：\imgin[缩放]{对齐}{路径}，对齐默认居中 l=左 r=右
\newcommand{\imgin}[3][0.38]{%
    \par
    \begin{minipage}[t]{1.0\textwidth}
        \ifx&#2& % 检测对齐参数是否为空
            \centering
        \else
            \ifx#2l
                \raggedright
            \else
                \ifx#2r
                    \raggedleft
                \else
                    \centering
                \fi
            \fi
        \fi
        \includegraphics[scale=#1]{#3}
    \end{minipage}%
}

% 自由标题：\autotilte[对齐]{标题}{副标题}
% \autotitle 为正确拼写的别名（两者等效）
\newcommand{\autotilte}[3][]{%
    \par
    \ifx&#1&
        \centering
    \else
        \ifx#1l
            \raggedright
        \else
            \ifx#1r
                \raggedleft
            \else
                \centering
            \fi
        \fi
    \fi
    \begingroup \heiti{#2} \endgroup #3%
    \par
}
\newcommand{\autotitle}{\autotilte}

% 批量插图：\insertimg{起}{止}{缩放}{对齐}{目录前缀}
\newcommand{\insertimg}[5]{%
    \foreach \n in {#1,...,#2} {%
        \begin{bbox}
            \imgin[#3]{#4}{#5/\n.png}%
        \end{bbox}%
    }%
}

% 随机水印：\randomtextwater[概率百分比]{文字}
\newcommand{\randomtextwater}[2][1]{%
    \pgfmathsetmacro{\randnum}{int(rnd*100)}%
    \ifnum \randnum<#1
        #2%
    \fi
}

% ============================================================
% Section 9 : 封面设计（现代极简 · 侧面色块 + 大字标题）
%
% 布局：左侧 35% 页宽为主题色实心色块，右侧 65% 为白色
% 文字排版区。所有颜色元素使用 themeColor，随主题自动切换。
% 全部使用 \paperwidth/\paperheight 相对坐标以适配 A4/B5。
% ============================================================

\renewcommand{\maketitle}{%
    \begin{titlepage}
        \begin{tikzpicture}[remember picture, overlay]

            % --- 左侧主题色块 ---
            \fill[themeColor] (current page.north west)
                rectangle ++(0.35\paperwidth, -\paperheight);

            % --- 色块内装饰：两个极淡白色方块，增加层次 ---
            \fill[white!10]
                ([xshift=0.35\paperwidth-1.5cm, yshift=1.5cm]current page.south west)
                rectangle ++(0.6cm, -0.6cm);
            \fill[white!8]
                ([xshift=1cm, yshift=-1cm]current page.north west)
                rectangle ++(0.3cm, -0.3cm);

            % --- 垂直分界线（色块右侧 2mm）---
            \draw[line width=0.3pt, themeColor!40]
                ([xshift=0.35\paperwidth+2mm]current page.north west)
                -- ++(0, -\paperheight);

            % --- 前置标题 ---
            \node[anchor=north west, align=left]
                at ([xshift=0.35\paperwidth+2cm, yshift=-0.3\paperheight]current page.north west)
                {\fontsize{14pt}{18pt}\selectfont\color{themeColor!80} \ExPress@value@PreTitle};

            % --- 主标题（大字号，粗黑体，允许换行）---
            \node[anchor=north west, align=left, text width=0.55\paperwidth]
                at ([xshift=0.35\paperwidth+2cm, yshift=-0.38\paperheight]current page.north west)
                {\fontsize{48pt}{52pt}\selectfont\bfseries\color{black!85} \ExPress@value@Title};

            % --- 装饰线（标题下方，主题色，4cm 长）---
            \draw[line width=1.8pt, themeColor]
                ([xshift=0.35\paperwidth+2cm, yshift=-0.52\paperheight]current page.north west)
                -- ++(4cm, 0);

            % --- 副标题 ---
            \node[anchor=north west, align=left, text width=0.5\paperwidth]
                at ([xshift=0.35\paperwidth+2cm, yshift=-0.56\paperheight]current page.north west)
                {\fontsize{18pt}{24pt}\selectfont\color{black!55} \ExPress@value@Subtitle};

            % --- 作者框（右下角，细线矩形 + 居中文字）---
            \draw[line width=0.8pt, themeColor!60, rounded corners=1pt]
                ([xshift=-2cm, yshift=2.5cm]current page.south east)
                rectangle ++(-4cm, 0.8cm);
            \node[anchor=center, align=center]
                at ([xshift=-4cm, yshift=2.9cm]current page.south east)
                {\fontsize{11pt}{14pt}\selectfont\color{themeColor} \ExPress@value@Author};

            % --- 座右铭 ---
            \node[anchor=east, align=right]
                at ([xshift=-2cm, yshift=1.8cm]current page.south east)
                {\fontsize{10pt}{14pt}\selectfont\color{black!35}\itshape \ExPress@value@Motto};

            % --- 更新时间 ---
            \node[anchor=east, align=right]
                at ([xshift=-2cm, yshift=1.2cm]current page.south east)
                {\fontsize{8pt}{10pt}\selectfont\color{black!25} \ExPress@value@UpdateTime};

            % --- 在线勘误链接（可选）---
            \if@online
                \node[anchor=south east, align=right]
                    at ([xshift=-2cm, yshift=0.5cm]current page.south east)
                    {\fontsize{8pt}{10pt}\selectfont\color{themeColor!50}
                     \href{\ExPress@value@OnlineCheckUrl}{在线勘误 →}};
            \fi

            % --- 封面图片叠加（可选，仅在设置了 \CoverImg 时）---
            \ifx\ExPress@value@CoverImg\empty
            \else
                \node[anchor=north west, inner sep=0pt]
                    at (current page.north west)
                    {\includegraphics[width=0.35\paperwidth, height=\paperheight,
                        keepaspectratio=false]{\ExPress@value@CoverImg}};
                \fill[themeColor, opacity=0.85]
                    (current page.north west) rectangle ++(0.35\paperwidth, -\paperheight);
            \fi

        \end{tikzpicture}
    \end{titlepage}

    % 打印模式：封面后加空白背页
    \if@printmode
        \clearpage\null\thispagestyle{empty}\clearpage
    \fi
}

% ============================================================
% Section 10 : 页眉页脚
%
% showmark 开启：偶数页自动显示章名，奇数页显示节名
% showmark 关闭：使用用户在 config.tex 中设置的静态文本
% ============================================================

\pagestyle{fancy}
\fancyhf{}

\if@showmark
    \fancyhead[LE]{\color{themeColor}\kaishu \truncate{7cm}{\leftmark}}
    \fancyhead[RO]{\color{themeColor}\kaishu \truncate{7cm}{\rightmark}}
    \if@notocnum
        \renewcommand{\chaptermark}[1]{\markboth{#1}{}}
        \renewcommand{\sectionmark}[1]{\markright{#1}{}}
    \else
        \renewcommand{\chaptermark}[1]{\markboth{\@chapapp\ \thechapter\ #1}{}}
        \renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}{}}
    \fi
\else
    % --- 静态页眉模式 ---
    \fancyhead[L]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExPress@value@Lhead}}}
    \fancyhead[C]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExPress@value@Chead}}}
    \fancyhead[R]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExPress@value@Rhead}}}
\fi

\fancyfoot[C]{\color{themeColor} 第 \thepage 页 / 共 \pageref{LastPage} 页}

\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

% ============================================================
% Section 11 : 章/节标题格式化（titlesec + titletoc）
%
% 字号层级：chapter 26pt → section 16pt → subsection 14pt
%          → subsubsection 13pt → paragraph 12pt
% 所有标题使用精确字号（非 \Huge 等相对命令），确保一致性。
% ============================================================

\if@notocnum
    % --- 无编号模式 ---
    \titlecontents{chapter}[0em]
        {\heiti\color{themeColor}}
        {}
        {}
        {\titlerule*[0.4pc]{.}\contentspage}

    \titlecontents{section}[2em]
        {}
        {}
        {}
        {\titlerule*[0.4pc]{.}\contentspage}

    \titlecontents{subsection}[4em]
        {}
        {}
        {}
        {\titlerule*[0.4pc]{.}\contentspage}

    \titlecontents{subsubsection}[6em]
        {}
        {}
        {}
        {\titlerule*[0.4pc]{.}\contentspage}

    \titleformat{\chapter}[display]
        {\sffamily\heiti\fontsize{26pt}{32pt}\selectfont\color{themeColor}}
        {}
        {0em}
        {}

    \titlespacing{\chapter}{0pt}{20pt plus 4pt minus 4pt}{20pt plus 4pt minus 4pt}

    \titleformat{\section}
        {\sffamily\heiti\fontsize{16pt}{20pt}\selectfont\color{themeColor}}
        {}
        {0em}
        {}

    \titlespacing{\section}{0pt}{14pt plus 2pt minus 2pt}{8pt plus 2pt minus 2pt}

    \titleformat{\subsection}
        {\sffamily\bfseries\fontsize{14pt}{18pt}\selectfont}
        {}
        {0em}
        {}

    \titlespacing{\subsection}{0pt}{10pt plus 2pt minus 2pt}{6pt plus 2pt minus 2pt}

    \titleformat{\subsubsection}
        {\sffamily\bfseries\fontsize{13pt}{16pt}\selectfont}
        {}
        {0em}
        {}

    \titlespacing{\subsubsection}{0pt}{8pt plus 2pt minus 2pt}{4pt plus 2pt minus 2pt}

    \titleformat{\paragraph}
        {\sffamily\bfseries\fontsize{12pt}{16pt}\selectfont}
        {}
        {0em}
        {}

    \titlespacing{\paragraph}{0pt}{6pt plus 2pt minus 2pt}{2pt plus 2pt minus 2pt}

\else
    % --- 有编号模式 ---
    \titlecontents{chapter}[0em]
        {\heiti\color{themeColor}}
        {\chaptername\ \thecontentslabel\ \hspace{1em}}
        {}
        {\titlerule*[0.4pc]{.}\contentspage}

    \titlecontents{section}[2em]
        {}
        {\thecontentslabel \hspace{1em}}
        {}
        {\titlerule*[0.4pc]{.}\contentspage}

    \titlecontents{subsection}[4em]
        {}
        {\thecontentslabel \hspace{1em}}
        {}
        {\titlerule*[0.4pc]{.}\contentspage}

    \titlecontents{subsubsection}[6em]
        {}
        {\thecontentslabel \hspace{1em}}
        {}
        {\titlerule*[0.4pc]{.}\contentspage}

    \titleformat{\chapter}[display]
        {\sffamily\heiti\fontsize{16pt}{20pt}\selectfont\color{themeColor}}
        {\chaptername\ \thechapter}
        {1em}
        {\sffamily\heiti\fontsize{26pt}{32pt}\selectfont\color{themeColor}}

    \titlespacing{\chapter}{0pt}{20pt plus 4pt minus 4pt}{20pt plus 4pt minus 4pt}

    \titleformat{\section}
        {\sffamily\heiti\fontsize{16pt}{20pt}\selectfont\color{themeColor}}
        {\thesection}
        {0.6em}
        {}

    \titlespacing{\section}{0pt}{14pt plus 2pt minus 2pt}{8pt plus 2pt minus 2pt}

    \titleformat{\subsection}
        {\sffamily\bfseries\fontsize{14pt}{18pt}\selectfont}
        {\thesubsection}
        {0.6em}
        {}

    \titlespacing{\subsection}{0pt}{10pt plus 2pt minus 2pt}{6pt plus 2pt minus 2pt}

    \titleformat{\subsubsection}
        {\sffamily\bfseries\fontsize{13pt}{16pt}\selectfont}
        {\thesubsubsection}
        {0.6em}
        {}

    \titlespacing{\subsubsection}{0pt}{8pt plus 2pt minus 2pt}{4pt plus 2pt minus 2pt}

    \titleformat{\paragraph}
        {\sffamily\bfseries\fontsize{12pt}{16pt}\selectfont}
        {\theparagraph}
        {0.6em}
        {}

    \titlespacing{\paragraph}{0pt}{6pt plus 2pt minus 2pt}{2pt plus 2pt minus 2pt}
\fi

% ============================================================
% Section 12 : 列表样式（TikZ 绘制项目符号）
%
% itemize：主题色实心小方块（一级）/ 空心圆（二级）/ 短线（三级）
% enumerate：主题色编号，一级加粗
% ============================================================

% 一级项目符号：主题色实心小方块（与封面几何风格统一）
\newcommand{\ExPress@itemi}{%
    \tikz[baseline=-0.5ex]{\fill[themeColor] (0,0) rectangle (0.38em,0.38em);}%
}

% 二级项目符号：主题色空心圆
\newcommand{\ExPress@itemii}{%
    \tikz[baseline=-0.5ex]{\draw[line width=0.4pt, themeColor] (0,0) circle (0.22em);}%
}

% 三级项目符号：主题色短横线
\newcommand{\ExPress@itemiii}{%
    \tikz[baseline=-0.5ex]{\draw[line width=0.5pt, themeColor] (0,0) -- (0.55em,0);}%
}

% itemize 配置
\setlist[itemize,1]{label=\ExPress@itemi, leftmargin=1.5em, itemsep=2pt plus 1pt minus 1pt}
\setlist[itemize,2]{label=\ExPress@itemii, leftmargin=1.5em, itemsep=1pt plus 1pt minus 1pt}
\setlist[itemize,3]{label=\ExPress@itemiii, leftmargin=1.5em, itemsep=1pt plus 1pt minus 1pt}

% enumerate 配置：主题色编号
\setlist[enumerate,1]{label=\color{themeColor}\bfseries\arabic*., leftmargin=1.8em, itemsep=2pt plus 1pt minus 1pt}
\setlist[enumerate,2]{label=\color{themeColor}(\alph*), leftmargin=1.8em, itemsep=1pt plus 1pt minus 1pt}
\setlist[enumerate,3]{label=\color{themeColor}\roman*., leftmargin=1.8em, itemsep=1pt plus 1pt minus 1pt}

% description 配置：主题色标签
\setlist[description]{font=\color{themeColor}\bfseries, leftmargin=2em, itemsep=2pt plus 1pt minus 1pt}

% ============================================================
% Section 13 : 前言 / 附录 / 参考文献环境
% ============================================================

% 前言：无编号章节，加入 TOC，无页眉页脚
\NewEnviron{preface}{%
    \chapter*{前言}%
    \addcontentsline{toc}{chapter}{前言}%
    \thispagestyle{empty}%
    \BODY
    \clearpage
}

% 附录：章号重置为 A, B, C...，\chapter 自动切换为 "附录 A" 格式
\NewEnviron{appendices}{%
    \appendix
    \renewcommand{\chaptername}{附录}%
    \titlecontents{chapter}[0em]
        {\heiti}
        {附录 \thecontentslabel\ \hspace{1em}}
        {}
        {\titlerule*[0.4pc]{.}\contentspage}%
    \BODY
}

% 参考文献：无编号章节 + thebibliography 包装
\newenvironment{references}{%
    \chapter*{参考文献}%
    \addcontentsline{toc}{chapter}{参考文献}%
    \begin{thebibliography}{99}%
}{%
    \end{thebibliography}%
}

% ============================================================
% Section 14 : 边注开关
%
% 类选项 marginnotes 或 \marginnotetoggle{on} 启用边注。
% 边注显示在页面外侧；关闭时回退为脚注。
% ============================================================

\newcommand{\marginnotetoggle}[1]{%
    \ifx#1on%
        \@marginnotestrue
        \reversemarginpar
    \else
        \@marginnotesfalse
    \fi
}

\newcommand{\mynote}[1]{%
    \if@marginnotes
        \marginpar{\raggedright\footnotesize\color{themeColor} #1}%
    \else
        \footnote{#1}%
    \fi
}

% ============================================================
% Section 15 : 图/表题注
%
% 编号方式：按章编号（Fig.1-1, Table.2-3 等）。
% 题注标签使用主题色粗体，文字使用主题色正体。
% ============================================================

\numberwithin{figure}{chapter}
\numberwithin{table}{chapter}

\DeclareCaptionFont{themecolor}{\color{themeColor}}
\captionsetup{
    labelfont={themecolor,bf},
    textfont={themecolor},
    labelsep=period,
    format=hang,
    justification=centering
}

% ============================================================
% Section 16 : 习题系统
%
% 完全保留 ExBook 的设计：
%   - qitems 环境（xkeyval 键值选项）
%   - bbox 环境（单题框，仅此一种模式）
%   - \qitem 命令（带两个可选参数）
%   - analysis 环境（\box0 吞咽技术隐藏解析）
%   - subqitems 小问列表
%   - \threechoices ～ \sixchoices 自动列排版
% ============================================================

\makeatletter
\newcounter{QuestionCounter}

\newif\if@resetcounter
\newif\if@showcounter

\@resetcountertrue
\@showcountertrue

% qitems 环境的键值定义
\define@key{qitems}{unreset}[true]{\@resetcounterfalse}
\define@key{qitems}{unshow}[true]{\@showcounterfalse}
\define@key{qitems}{showanalysis}[true]{\@showanalysistrue}
\define@key{qitems}{prefix}[]{\def\@prefix{#1}}
\define@key{qitems}{suffix}[.]{\def\@suffix{#1}}
\define@key{qitems}{optprefix}[]{\def\@optprefix{#1}}
\define@key{qitems}{optsuffix}[]{\def\@optsuffix{#1}}
\define@key{qitems}{startnum}[0]{\def\@startnum{#1}}

% qitems 环境定义
\newenvironment{qitems}[1][]{
    \begingroup
    \setkeys{qitems}{#1}

    \if@resetcounter
        \setcounter{QuestionCounter}{0}
    \fi

    \ifx\@prefix\undefined
        \def\@prefix{}
    \fi
    \ifx\@suffix\undefined
        \def\@suffix{.}
    \fi

    \ifx\@optprefix\undefined
        \def\@optprefix{}
    \fi
    \ifx\@optsuffix\undefined
        \def\@optsuffix{.}
    \fi

    \ifx\@startnum\undefined
        \def\@startnum{0}
    \else
        \setcounter{QuestionCounter}{\@startnum}
        \addtocounter{QuestionCounter}{-1}
    \fi

    \par \begingroup \par
}{
    \par \endgroup \par
    \endgroup
    \clearpage
}

% 题目命令：\qitem[前缀][后缀]
\NewDocumentCommand{\qitem}{O{} O{}}{
    \stepcounter{QuestionCounter}
    \vspace{2mm}
    \if@showcounter
        #1\@prefix\arabic{QuestionCounter}\@suffix#2
    \else
        #1\@prefix\@suffix#2
    \fi
}

% bbox 环境（单一模式：minipage + 2.5cm 间距）
\newenvironment{bbox}
{%
    \begin{minipage}{\textwidth}%
}{%
    \vspace*{2.5cm}%
    \end{minipage}%
    \if@water
        \begin{tikzpicture}[overlay,remember picture]
            \node[anchor=east, opacity=0.02]
                at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)
                {\includegraphics[width=0.16\textwidth]{\ExPress@value@WaterImg}};
        \end{tikzpicture}%
    \fi
}

% 解析环境：\if@showanalysis 为假时，内容吸入 \box0 丢弃
\newenvironment{analysis}[1][解析：]{
    \par
    \if@showanalysis
        \vspace{2mm}
        \if@darkmode
            \begin{tcolorbox}[
                left=2mm,
                right=2mm,
                top=2mm,
                bottom=1mm,
                boxrule=0mm,
                leftrule=2pt,
                colframe=themeColor!60,
                arc=2mm,
                outer arc=2mm,
                opacityback=0.05,
                opacityframe=0.05,
                nobeforeafter
            ]
            \fontsize{11}{0}
            \textbf{\color{white}\kaishu#1}
            \kaishu \color{white!80}
            \ignorespaces
        \else
            \begin{tcolorbox}[
                left=2mm,
                right=2mm,
                top=2mm,
                bottom=1mm,
                boxrule=0mm,
                leftrule=2pt,
                colback=themeColor!5,
                colframe=themeColor,
                arc=2mm,
                outer arc=2mm,
                nobeforeafter
            ]
            \fontsize{11}{0}
            \textbf{\color{themeColor}\kaishu #1}
            \kaishu
            \ignorespaces
        \fi
    \else
        \setbox0=\vbox\bgroup
    \fi
}{
    \if@showanalysis
        \end{tcolorbox}
        \par
    \else
        \egroup
    \fi
}

% 小问列表
\newlist{subqitems}{enumerate}{2}
\setlist[subqitems,1]{label=(\arabic*)}
\setlist[subqitems,2]{label=(\roman*)}

\newcommand{\subqitem}{\item}

% ============================================================
% 选择题选项自动排版
%
% 算法：测量每个选项宽度取最大值 \maxlength，按阈值分行：
%   \maxlength > 0.4\linewidth → 单列
%   \maxlength > 0.2\linewidth → 双列
%   否则 → 四列（三选项为三列）
% ============================================================

\newlength{\choicelengtha}
\newlength{\choicelengthb}
\newlength{\choicelengthc}
\newlength{\choicelengthd}
\newlength{\choicelengthe}
\newlength{\maxlength}

% 三个选项
\newcommand{\threechoices}[3]{
    \par
    \settowidth{\choicelengtha}{\@optprefix A\@optsuffix~#1~~~}
    \settowidth{\choicelengthb}{\@optprefix B\@optsuffix~#2~~~}
    \settowidth{\choicelengthc}{\@optprefix C\@optsuffix~#3~~~}

    \ifthenelse{\lengthtest{\choicelengtha>\choicelengthb}}{\setlength{\maxlength}{\choicelengtha}}{\setlength{\maxlength}{\choicelengthb}}
    \ifthenelse{\lengthtest{\choicelengthc>\maxlength}}{\setlength{\maxlength}{\choicelengthc}}{}
    \ifthenelse{\lengthtest{\maxlength>0.4\linewidth}}
    {
        \begin{tabularx}{\linewidth}{X}
            \setlength\tabcolsep{0pt}
            \@optprefix A\@optsuffix~#1~~~\\
            \@optprefix B\@optsuffix~#2~~~\\
            \@optprefix C\@optsuffix~#3~~~\\
        \end{tabularx}
    }%
    {
        \ifthenelse{\lengthtest{\maxlength>0.2\linewidth}}
        {
            \begin{tabularx}{\linewidth}{XX}
                \setlength\tabcolsep{0pt}
                \@optprefix A\@optsuffix~#1~~~ & \@optprefix B\@optsuffix~#2~~~\\
                \@optprefix C\@optsuffix~#3~~~ & \\
            \end{tabularx}
        }%
        {
            \begin{tabularx}{\linewidth}{XXXX}
                \setlength\tabcolsep{0pt}
                \@optprefix A\@optsuffix~#1~~~  & \@optprefix B\@optsuffix~#2~~~ & \@optprefix C\@optsuffix~#3~~~ &\\
            \end{tabularx}
        }
    }
    \unskip \unskip
}

% 四个选项
\newcommand{\fourchoices}[4]{
    \par
    \settowidth{\choicelengtha}{\@optprefix A\@optsuffix~#1~~~}
    \settowidth{\choicelengthb}{\@optprefix B\@optsuffix~#2~~~}
    \settowidth{\choicelengthc}{\@optprefix C\@optsuffix~#3~~~}
    \settowidth{\choicelengthd}{\@optprefix D\@optsuffix~#4~~~}
    \ifthenelse{\lengthtest{\choicelengtha>\choicelengthb}}{\setlength{\maxlength}{\choicelengtha}}{\setlength{\maxlength}{\choicelengthb}}
    \ifthenelse{\lengthtest{\choicelengthc>\maxlength}}{\setlength{\maxlength}{\choicelengthc}}{}
    \ifthenelse{\lengthtest{\choicelengthd>\maxlength}}{\setlength{\maxlength}{\choicelengthd}}{}
    \ifthenelse{\lengthtest{\maxlength>0.4\linewidth}}
    {
        \begin{tabularx}{\linewidth}{X}
            \setlength\tabcolsep{0pt}
            \@optprefix A\@optsuffix~#1~~~\\
            \@optprefix B\@optsuffix~#2~~~\\
            \@optprefix C\@optsuffix~#3~~~\\
            \@optprefix D\@optsuffix~#4~~~\\
        \end{tabularx}
    }%
    {
        \ifthenelse{\lengthtest{\maxlength>0.2\linewidth}}
        {
            \begin{tabularx}{\linewidth}{XX}
                \setlength\tabcolsep{0pt}
                \@optprefix A\@optsuffix~#1~~~ & \@optprefix B\@optsuffix~#2~~~\\
                \@optprefix C\@optsuffix~#3~~~ & \@optprefix D\@optsuffix~#4~~~\\
            \end{tabularx}
        }%
        {
            \begin{tabularx}{\linewidth}{XXXX}
                \setlength\tabcolsep{0pt}
                \@optprefix A\@optsuffix~#1~~~  & \@optprefix B\@optsuffix~#2~~~ & \@optprefix C\@optsuffix~#3~~~ & \@optprefix D\@optsuffix~#4~~~\\
            \end{tabularx}
        }%
    }
    \unskip \unskip
}

% 五个选项
\newcommand{\fivechoices}[5]{
    \par
    \settowidth{\choicelengtha}{\@optprefix A\@optsuffix~#1~~~}
    \settowidth{\choicelengthb}{\@optprefix B\@optsuffix~#2~~~}
    \settowidth{\choicelengthc}{\@optprefix C\@optsuffix~#3~~~}
    \settowidth{\choicelengthd}{\@optprefix D\@optsuffix~#4~~~}
    \settowidth{\choicelengthe}{\@optprefix E\@optsuffix~#5~~~}
    \ifthenelse{\lengthtest{\choicelengtha>\choicelengthb}}{\setlength{\maxlength}{\choicelengtha}}{\setlength{\maxlength}{\choicelengthb}}
    \ifthenelse{\lengthtest{\choicelengthc>\maxlength}}{\setlength{\maxlength}{\choicelengthc}}{}
    \ifthenelse{\lengthtest{\choicelengthd>\maxlength}}{\setlength{\maxlength}{\choicelengthd}}{}
    \ifthenelse{\lengthtest{\choicelengthe>\maxlength}}{\setlength{\maxlength}{\choicelengthe}}{}
    \ifthenelse{\lengthtest{\maxlength>0.4\linewidth}}{
        \begin{tabularx}{\linewidth}{X}
            \setlength\tabcolsep{0pt}
            \@optprefix A\@optsuffix~#1~~~\\
            \@optprefix B\@optsuffix~#2~~~\\
            \@optprefix C\@optsuffix~#3~~~\\
            \@optprefix D\@optsuffix~#4~~~\\
            \@optprefix E\@optsuffix~#5~~~\\
        \end{tabularx}
    }%
    {
        \ifthenelse{\lengthtest{\maxlength>0.2\linewidth}}
        {
            \begin{tabularx}{\linewidth}{XX}
                \setlength\tabcolsep{0pt}
                \@optprefix A\@optsuffix~#1~~~ & \@optprefix B\@optsuffix~#2~~~\\
                \@optprefix C\@optsuffix~#3~~~ & \@optprefix D\@optsuffix~#4~~~\\
                \@optprefix E\@optsuffix~#5~~~ &         \\
            \end{tabularx}
        }%
        {
            \begin{tabularx}{\linewidth}{XXXX}
                \setlength\tabcolsep{0pt}
                \@optprefix A\@optsuffix~#1~~~  & \@optprefix B\@optsuffix~#2~~~ & \@optprefix C\@optsuffix~#3~~~ & \@optprefix D\@optsuffix~#4~~~ \\
                \@optprefix E\@optsuffix~#5~~~  &          &          &          \\
            \end{tabularx}
        }
    }%
    \unskip \unskip
}

% 六个选项
\newcommand{\sixchoices}[6]{
    \par
    \settowidth{\choicelengtha}{\@optprefix A\@optsuffix~#1~~~}
    \settowidth{\choicelengthb}{\@optprefix B\@optsuffix~#2~~~}
    \settowidth{\choicelengthc}{\@optprefix C\@optsuffix~#3~~~}
    \settowidth{\choicelengthd}{\@optprefix D\@optsuffix~#4~~~}
    \settowidth{\choicelengthe}{\@optprefix E\@optsuffix~#5~~~}
    \ifthenelse{\lengthtest{\choicelengtha>\choicelengthb}}{\setlength{\maxlength}{\choicelengtha}}{\setlength{\maxlength}{\choicelengthb}}
    \ifthenelse{\lengthtest{\choicelengthc>\maxlength}}{\setlength{\maxlength}{\choicelengthc}}{}
    \ifthenelse{\lengthtest{\choicelengthd>\maxlength}}{\setlength{\maxlength}{\choicelengthd}}{}
    \ifthenelse{\lengthtest{\choicelengthe>\maxlength}}{\setlength{\maxlength}{\choicelengthe}}{}

    \ifthenelse{\lengthtest{\maxlength>0.4\linewidth}}
    {
        \begin{tabularx}{\linewidth}{X}
            \setlength\tabcolsep{0pt}
            \@optprefix A\@optsuffix~#1~~~\\
            \@optprefix B\@optsuffix~#2~~~\\
            \@optprefix C\@optsuffix~#3~~~\\
            \@optprefix D\@optsuffix~#4~~~\\
            \@optprefix E\@optsuffix~#5~~~\\
            \@optprefix F\@optsuffix~#6~~~\\
        \end{tabularx}
    }%
    {
        \ifthenelse{\lengthtest{\maxlength>0.2\linewidth}}
        {
            \begin{tabularx}{\linewidth}{XX}
                \setlength\tabcolsep{0pt}
                \@optprefix A\@optsuffix~#1~~~ & \@optprefix B\@optsuffix~#2~~~\\
                \@optprefix C\@optsuffix~#3~~~ & \@optprefix D\@optsuffix~#4~~~\\
                \@optprefix E\@optsuffix~#5~~~ & \@optprefix F\@optsuffix~#6~~~\\
            \end{tabularx}
        }%
        {
            \begin{tabularx}{\linewidth}{XXXX}
                \setlength\tabcolsep{0pt}
                \@optprefix A\@optsuffix~#1~~~  & \@optprefix B\@optsuffix~#2~~~ & \@optprefix C\@optsuffix~#3~~~ & \@optprefix D\@optsuffix~#4~~~ \\
                \@optprefix E\@optsuffix~#5~~~  & \@optprefix F\@optsuffix~#6~~~ &          &          \\
            \end{tabularx}
        }%
    }
    \unskip \unskip
}

\makeatother

% ============================================================
% Section 17 : 解答环境（tcolorbox + 深/亮双模式）
% ============================================================

\NewEnviron{solution}{%
    \makeatletter
    \if@enableSolution
        \par\medskip\noindent
        \if@darkmode
            \begin{tcolorbox}[
                breakable,
                boxrule=0.5pt,
                arc=2mm,
                boxsep=4pt,
                left=2pt,
                right=2pt,
                colback=bg!60!black,
                colframe=themeColor,
                title={\heiti\bfseries 解答},
                fonttitle=\bfseries,
                colbacktitle=themeColor,
                coltitle=white
            ]
            \BODY
            \end{tcolorbox}
        \else
            \begin{tcolorbox}[
                breakable,
                boxrule=0.5pt,
                arc=2mm,
                boxsep=4pt,
                left=2pt,
                right=2pt,
                colback=themeColor!5!white,
                colframe=themeColor,
                title={\heiti\bfseries 解答},
                fonttitle=\bfseries,
                colbacktitle=themeColor,
                coltitle=white
            ]
            \BODY
            \end{tcolorbox}
        \fi
    \fi
    \makeatother
}

% ============================================================
% Section 18 : 水印系统
%
% 两种水印：行内文字水印（\textwater）和页面图片水印
% （在 bbox 结束时的右下角），由 water 选项控制。
% ============================================================
% （水印渲染已集成到 bbox 环境末尾）

% ============================================================
% Section 19 : AtBeginDocument 钩子
% ============================================================

\makeatletter
\AtBeginDocument{
    \pagenumbering{arabic}
    \@addtoreset{footnote}{chapter}  % 脚注每章重置
}
\makeatother

% ============================================================
% Section 20 : 类文件结束
% ============================================================
\endinput
