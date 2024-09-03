# LuaLaTeX Template
![Static Badge](https://img.shields.io/badge/LuaLaTeX-green?logo=latex)
![GitHub top language](https://img.shields.io/github/languages/top/cohsh/latex-template?logo=lua)

A LuaLaTeX Template with Subfiles Package

## Features

- [x] The text is written in sub `.tex` files.
- [x] Automatic generation of main and sub `.tex` files
- [x] Automatic loads of sub `.tex` files by using `luacode*`
- [x] Not redundant `\usepackage` (`./sty/common.sty` only)

## Components
```
.
├── Makefile
├── README.md
├── generate.sh
├── parts
│   └── sub
│       ├── article.tex
│       ├── beamer.tex
│       ├── book.tex
│       ├── report.tex
│       └── revtex.tex
├── sty
│   └── common.sty
└── utility
    ├── core.lua
    ├── figure.lua
    └── load.lua
```

- `generate.sh`: use for generating `main.tex` in `Makefile`
- `parts/sub/*`: use for generating sub `.tex` files in `Makefile`
- `sty/common.sty`: listing of `\usepackage`
- `utility/*`: utility Lua codes

## Usage for `article.cls`
### 1. Generate files
```shell
make article
```  

### 2. Edit
  #### 2.1 Please edit `main.tex` for `\maketitle`.
  ```latex
  \title{}
  \author{}
  \date{\today}
  ```
  #### 2.2 Please edit `sub/*` as you like.

### 3. Build
```shell
make
```
or
```shell
latexmk
```

The generated `main.pdf` is at `cache/main.pdf`

## Supported Classes
- Basic
  - `book.cls`
  - `article.cls`
  - `report.cls`

- Slide
  - `beamer.cls`

- REVTeX
  - `revtex4-2.cls`

- Japanese
  - `ltjsbook.cls`
  - `ltjsarticle.cls`
  - `ltjsreport.cls`

## Note
### Generated files for `article.cls`
```
.
├── fig
├── main.bib
├── main.tex
├── sty
│   └── common.sty
├── sub
│   └── part1
│       ├── section0.tex
│       ├── section1.tex
│       ├── section10.tex
│       ├── section2.tex
│       ├── section3.tex
│       ├── section4.tex
│       ├── section5.tex
│       ├── section6.tex
│       ├── section7.tex
│       ├── section8.tex
│       └── section9.tex
└── utility
    ├── core.lua
    ├── figure.lua
    └── load.lua
```

- `main.tex`

```latex
\documentclass[11pt, a4paper]{article}
\usepackage{./sty/common}



\begin{luacode*}
    local core = require("./utility/core")
\end{luacode*}

\graphicspath{{./fig/}}

\title{}
\author{}
\date{\today}

\begin{document}
    \maketitle

    \tableofcontents

    \begin{luacode*}
        local load = require("./utility/load")
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