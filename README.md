# My $\LaTeX$ Template
## Main Components
- sty/: style file
- templates/: templates files
- utility/: utility Lua code
- Makefile

## Supported Class Files
- ltjsbook
- ltjsarticle
- beamer

## Usage
### Example (beamer)
- Generate `main.tex`, `main.bib`, and `sub/` in `src-test/`
```shell
make NAME="src-test" beamer
```

- Build
```shell
make NAME="src-test"
```

- Clean
```shell
make NAME="src-test" clean
```