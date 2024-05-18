#!/bin/zsh

class=$1
option=""
optional_preamble=""

if [ "$class" != "beamer" ]; then
    option="11pt, a4paper"
    optional_preamble=""
    maketitle=$(cat << EOF
    \maketitle
EOF
)
else
    option="11pt"
    optional_preamble=$(cat << EOF
\usetheme{Berkeley}
\usecolortheme[RGB={0,91,152}]{structure}

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
    \begin{frame}
        \titlepage
    \end{frame}
EOF
)
fi

books=("book" "ltjsbook")
articles=("article" "ltjsarticle")
reports=("report" "ltjsreport")

load="beamer"

if [[ "${books[(Ie)$class]}" -ne 0 ]]; then
    load="book"
elif [[ "${articles[(Ie)$class]}" -ne 0 ]]; then
    load="article"
elif [[ "${reports[(Ie)$class]}" -ne 0 ]]; then
    load="report"
fi

cat << EOF
\documentclass[$option]{$class}
\usepackage{./sty/common}

$optional_preamble

\begin{luacode*}
    local core = require("./utility/core")
\end{luacode*}

\graphicspath{{./fig/}}

\title{}
\author{}
\date{\today}

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