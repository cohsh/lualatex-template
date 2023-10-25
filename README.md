# LaTeX Template
A LuaLaTeX Template with Subfiles Package
## Main Components
- `sty/`: a style file
- `templates/`: template files
- `utility/`: utility Lua codes
- `Makefile`

## Supported Class Files
- ltjsbook
- ltjsarticle
- beamer

## Usage
### Examples
- Generate `document-hogehoge/`
  - For ltjsbook
  ```shell
  make ltjsarticle NAME="document-hogehoge"
  ```  

  - For ltjsarticle
  ```shell
  make ltjsarticle NAME="document-hogehoge"
  ```  

  - For beamer
  ```shell
  make beamer NAME="document-hogehoge"
  ```

- Build
```shell
make NAME="document-hogehoge"
```

- Clean
```shell
make clean NAME="document-hogehoge"
```