# LaTeX Template
A LuaLaTeX Template with Subfiles Package
## Main Components
- `sty/`: a style file
- `templates/`: template files
- `utility/`: utility Lua codes
- `input.lua`: an input file
- `Makefile`

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