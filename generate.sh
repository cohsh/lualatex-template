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