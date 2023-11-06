# LuaLaTeX Template
![Static Badge](https://img.shields.io/badge/LuaLaTeX-green?logo=latex)
![GitHub top language](https://img.shields.io/github/languages/top/cohsh/latex-template?logo=lua)

A LuaLaTeX Template with Subfiles Package

## Supported Classes
- Basic
  - `book.cls`
  - `article.cls`
  - `report.cls`

- Slide
  - `beamer.cls`

- Japanese
  - `ltjsbook.cls`
  - `ltjsarticle.cls`
  - `ltjsreport.cls`

## Components
```
.
├── Makefile
├── README.md
├── generate.sh
├── input.lua
├── sty
│   └── cohsh-common.sty
└── utility
    ├── core.lua
    ├── figure.lua
    ├── load.lua
    └── maketitle.lua
```

- `generate.sh`: used in `Makefile`
- `input.lua`: an input file for `\maketitle`
- `sty/cohsh-common.sty`: listing of `\usepackage`
- `utility/*`: utility Lua codes

## Usage for `article.cls`
### 1. Generate `test-document/`
```shell
make article NAME="test-document"
```  

### 2. Edit
  #### 2.1 Please edit the following lines in `./test-document/input.lua` for `\maketitle`.
  ```lua
    input.title = ""
    input.author = ""
  ```
  #### 2.2 Please write the text as you like in `sub/part1/section*.tex`.

### 3. Build
  #### At `.`
  ```shell
  make NAME="test-document"
  ```

  #### At `./test-document`
  ```shell
  cd test-document
  latexmk
  ```

The generated `main.pdf` is at `./test-document/cache/main.pdf`

## Files
### Generated files for `article.cls`
```
.
├── fig
├── input.lua
├── main.bib
├── main.tex
└── sub
    └── part1
        ├── section0.tex
        ├── section1.tex
        ├── section10.tex
        ├── section2.tex
        ├── section3.tex
        ├── section4.tex
        ├── section5.tex
        ├── section6.tex
        ├── section7.tex
        ├── section8.tex
        └── section9.tex
```

- `main.tex`

```latex
\documentclass[11pt, a4paper]{article}
\usepackage{../sty/cohsh-common}



\begin{luacode*}
    local core = require("../utility/core")
    local input = require("./input")

    maketitle = require("../utility/maketitle")
    maketitle:set()
\end{luacode*}

\graphicspath{{./fig/}}

\begin{document}

    \begin{luacode*}
        maketitle:execute()
    \end{luacode*}

    \tableofcontents

    \begin{luacode*}
        local core = require("../utility/core")
        local load = require("../utility/load")
        local subfile = load.SubFile:new("sub", 0, 10)
        subfile:article()
    \end{luacode*}
    
    \bibliography{main}
    \bibliographystyle{unsrt}

\end{document}
```

- `sub/part1/section0.tex`

```latex
\documentclass[../../main]{subfiles}
\begin{document}

\end{document}
```