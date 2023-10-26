# LaTeX Template
![Static Badge](https://img.shields.io/badge/LuaLaTeX-green?logo=latex)
![GitHub top language](https://img.shields.io/github/languages/top/cohsh/latex-template?logo=lua)

A LuaLaTeX Template with Subfiles Package
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
    ├── load.lua
    └── maketitle.lua
```
- `generate.sh`: used in `Makefile`
- `input.lua`: an input file for `\maketitle`
- `sty/cohsh-common.sty`: listing of `\usepackage`
- `utility/*`: utility Lua codes

## Supported Class Files
- Basic
  - book
  - article
  - report
- Slide
  - beamer
- Japanese
  - ltjsbook
  - ltjsarticle
  - ltjsreport

## Usage
### Examples
- Generate `document-hogehoge/`
  - For article
  ```shell
  make article NAME="document-hogehoge"
  ```  
  - For beamer
  ```shell
  make beamer NAME="document-hogehoge"
  ```

  - For ltjsbook
  ```shell
  make ltjsbook NAME="document-hogehoge"
  ```

- Build
```shell
make NAME="document-hogehoge"
```

- Clean
```shell
make clean NAME="document-hogehoge"
```