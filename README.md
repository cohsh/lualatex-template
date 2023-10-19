# My $\LaTeX$ Template
## Main Components
- sty/: style file
- templates/: "empty" `.tex` files
- utility/: Lua code
- Makefile

## Supported Class Files
- ltjsbook
- ltjsarticle
- beamer

## Usage
### Example (beamer)
- Generate `main.tex`, `main.bib`, and `sub/`
```shell
make beamer
```

- Build
```shell
make
```

- Clean
```shell
make clean
```