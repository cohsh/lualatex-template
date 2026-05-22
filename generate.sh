#!/usr/bin/env bash

class=$1
mode=${2:-subfiles}
option=""
optional_usepackage=""
optional_preamble=""

case "$class" in
    book|article|report|ltjsbook|ltjsarticle|ltjsreport|beamer|revtex)
        ;;
    *)
        echo "Error: unknown or missing document class: '${class}'" >&2
        echo "Usage: ${0##*/} <class> [subfiles|single]" >&2
        echo "  class: book|article|report|ltjsbook|ltjsarticle|ltjsreport|beamer|revtex" >&2
        exit 1
        ;;
esac

case "$mode" in
    subfiles|single)
        ;;
    *)
        echo "Error: unknown mode: '${mode}' (expected 'subfiles' or 'single')" >&2
        exit 1
        ;;
esac

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
        option="aspectratio=169,10pt"
        optional_preamble='\usepackage{./sty/beamer}'
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

if [ "$mode" = "subfiles" ]; then
    body=$(cat << EOF
    \begin{luacode*}
        local load = require("./utility/load")
        local subfile = load.SubFile:new("sub", 0, 10)
        subfile:$load()
    \end{luacode*}
EOF
)
else
    body="    % Write your content here."
fi

cat << EOF
\documentclass[$option]{$class}
\usepackage{./sty/common}
$optional_usepackage

$optional_preamble

\begin{luacode*}
    local core = require("./utility/core")
    local figure = require("./utility/figure")
\end{luacode*}

\graphicspath{{./fig/}}

\begin{document}
$maketitle

    \tableofcontents

$body

    \bibliography{main}
    \bibliographystyle{unsrt}

\end{document}
EOF