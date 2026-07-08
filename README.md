# LuaLaTeX Template
![Static Badge](https://img.shields.io/badge/LuaLaTeX-green?logo=latex)
![GitHub top language](https://img.shields.io/github/languages/top/cohsh/lualatex-template?logo=lua)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

A LuaLaTeX Template with Subfiles Package

## Features

- [x] The text is written in sub `.tex` files.
- [x] Automatic generation of main and sub `.tex` files
- [x] Automatic loads of sub `.tex` files by using `luacode*`
- [x] `\usepackage` directives organized in `sty/*.sty`
- [x] Single-file mode for small documents (`make <class>-single`)
- [x] Optional auto-compile hook for Claude Code (`make claude-hook`)

## Components
```
.
├── LICENSE
├── Makefile
├── README.md
├── claude
│   ├── compile-latex.sh
│   └── settings.hooks.json
├── assets
│   └── fig
│       ├── claude_ai_logo.{pdf,svg}
│       ├── codex_icon.{pdf,svg}
│       └── codex_logo.{pdf,svg}
├── generate.sh
├── parts
│   └── sub
│       ├── article.tex
│       ├── beamer.tex
│       ├── book.tex
│       ├── report.tex
│       └── revtex.tex
├── sty
│   ├── beamer.sty
│   └── common.sty
└── utility
    ├── core.lua
    ├── figure.lua
    └── load.lua
```

- `generate.sh`: use for generating `main.tex` in `Makefile`
- `assets/fig/*`: reusable figures copied into `fig/` by `make <class>`
- `claude/*`: Claude Code auto-compile hook, installed on demand by `make claude-hook`
- `parts/sub/*`: use for generating sub `.tex` files in `Makefile`
- `sty/common.sty`: `\usepackage` shared by all classes
- `sty/beamer.sty`: `\usepackage`, theme, and environments for the `beamer` class
- `utility/*`: utility Lua codes

For `beamer`, the generated title slide calls `\aiassistcredit`, which places
the `Created with Claude and Codex` credit and logos in the lower-right corner.

## Usage for `article.cls`
### 1. Generate files
```shell
make article
```  

For a small document, generate a single-file version (no `sub/`, write directly
in `main.tex`). This works for any class, e.g. `make beamer-single`:
```shell
make article-single
```

### 2. Edit
  #### 2.1 Please edit `main.tex` for `\maketitle`.
  ```latex
  \title{}
  \author{}
  \date{\today}
  ```
  #### 2.2 Please edit `sub/*` as you like (subfiles version), or write directly in `main.tex` (single-file version).

### 3. Build
```shell
make
```
or
```shell
latexmk
```

The generated `main.pdf` is at `cache/main.pdf`

### 4. Clean
Remove build artifacts (`cache/` and stray `main.*` outputs), keeping your document:
```shell
make clean
```
Remove every generated file and return to the pristine template state.
**Warning: this deletes `main.tex`, `main.bib`, `sub/` and `fig/`.**
```shell
make distclean
```

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

## Claude Code integration (optional)
If you edit `.tex` files with [Claude Code](https://claude.com/claude-code),
install the auto-compile hook once so the PDF rebuilds after every edit:
```shell
make claude-hook
```
This copies a `PostToolUse` hook into `.claude/`, which is git-ignored and local
to your working copy — other users and editors are unaffected. Requires `jq` and
`latexmk`.

Run it once per clone: it is independent of `make <class>` and is kept by
`make distclean`, so it never needs to be re-installed.

## Note
### Generated files for `article.cls`
```
.
├── fig
├── main.bib
├── main.tex
├── sty
│   ├── beamer.sty
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
    local figure = require("./utility/figure")
\end{luacode*}

\graphicspath{{./fig/}}

\begin{document}
    \title{}
    \author{}
    \date{\today}

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

### Single-file mode
`make <class>-single` generates only `main.tex` (no `sub/` directory). The
subfile-loading `luacode*` block is replaced by a placeholder where you write
the body directly:

```latex
\begin{document}
    \title{}
    \author{}
    \date{\today}

    \maketitle

    \tableofcontents

    % Write your content here.

    \bibliography{main}
    \bibliographystyle{unsrt}
\end{document}
```

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
