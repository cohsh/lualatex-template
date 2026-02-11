#!/bin/zsh

class=$1
option=""
optional_usepackage=""
optional_preamble=""

case "$class" in
    "revtex")
        option="twocolumn"
        maketitle=$(cat << EOF
    \title{}

    \author{}
    \affiliation{}
    \email{}

    \date{\today}

    \maketitle
EOF
);;
    "beamer")
        option="8pt"
        optional_preamble=$(cat << EOF
\usetheme{Madrid}

\definecolor{tabblue}{RGB}{31,119,180}
\definecolor{taborange}{RGB}{255,127,14}
\definecolor{tabgreen}{RGB}{44,160,44}
\definecolor{tabpurple}{RGB}{148,103,189}
\definecolor{tabred}{RGB}{214,39,40}

\usecolortheme[named=tabblue]{structure}

\setbeamertemplate{footline}[frame number]
\setbeamertemplate{navigation symbols}{}

\setbeamersize{text margin left=5pt, text margin right=5pt}

\setbeamercolor{page number in head/foot}{fg=tabblue}
\setbeamercolor{block title}{bg=tabblue}
\setbeamercolor{block title alerted}{bg=taborange}
\setbeamercolor{block title example}{bg=tabgreen}

\setbeamerfont{normal text}{size=\tiny}
\setbeamerfont{page number in head/foot}{family=\ttfamily, size=\normalsize}
\setbeamerfont{frametitle}{size=\large}
\setbeamerfont{title}{size=\Large}
\setbeamerfont{block title}{size=\normalsize}

\newenvironment<>{specialblock}[1]{%
  \begin{actionenv}#2%
    \def\insertblocktitle{#1}%
    \par%
    \mode<presentation>{%
      \setbeamercolor{block title}{bg=tabred}
      \setbeamercolor{block body}{bg=tabred!10}
    }%
    \usebeamertemplate{block begin}}
  {\par\usebeamertemplate{block end}\end{actionenv}}

\AtBeginSection[]{
    \begin{frame}
        \vfill
        \centering
        \begin{beamercolorbox}[sep=8pt,center,shadow=true,rounded=true]{title}
            \usebeamerfont{title}\insertsectionhead\par%
        \end{beamercolorbox}
        \vfill
    \end{frame}
}
EOF
)
        maketitle=$(cat << EOF
    \title{}
    \author{}
    \date{\today}

    \begin{frame}
        \titlepage
    \end{frame}
EOF
);;
    *)
        option="11pt, a4paper"
        maketitle=$(cat << EOF
    \title{}
    \author{}
    \date{\today}

    \maketitle
EOF
);;
esac

case "$class" in
    "ltjsbook"|"ltjsarticle"|"ltjsreport"|"beamer")
        optional_usepackage=$(cat << EOF
\usepackage{luatexja}
EOF
);;
esac

case "$class" in
    "book"|"ltjsbook")
        load="book"
        ;;
    "article"|"ltjsarticle")
        load="article"
        ;;
    "report"|"ltjsreport")
        load="report"
        ;;
    "beamer")
        load="beamer"
        ;;
    "revtex")
        load="revtex"
        class="revtex4-2"
        ;;
esac

cat << EOF
\documentclass[$option]{$class}
\usepackage{./sty/common}
$optional_usepackage

$optional_preamble

\begin{luacode*}
    local core = require("./utility/core")
\end{luacode*}

\graphicspath{{./fig/}}

\begin{document}
$maketitle

    \tableofcontents

    \begin{luacode*}
        local load = require("./utility/load")
        local subfile = load.SubFile:new("sub", 0, 10)
        subfile:$load()
    \end{luacode*}
    
    \bibliography{main}
    \bibliographystyle{unsrt}

\end{document}
EOF