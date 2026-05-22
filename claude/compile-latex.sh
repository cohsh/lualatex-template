#!/bin/bash
# Claude Code PostToolUse hook: when a .tex file is edited, rebuild the
# project's main.tex with latexmk.
#
# Starting from the edited file, walk up the directory tree to find main.tex
# and run latexmk there. Editing an \input fragment under sub/ (or similar)
# therefore triggers a full-document build, not a standalone compile.
#
# The LaTeX engine is left to latexmk flags / .latexmkrc:
#   LATEXMK_FLAGS="-pdf"   (switch to pdflatex; default: -lualatex)
#   (If needed, prefix the hook command in settings.json with
#    TEXMFCACHE=/tmp/texmf-var TEXMFVAR=/tmp/texmf-var.)
#
# Requires: jq, latexmk

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

[[ "$FILE_PATH" == *.tex ]] || exit 0

# Walk up from the edited file's directory to find main.tex
dir="$(cd "$(dirname "$FILE_PATH")" 2>/dev/null && pwd)" || exit 0
root=""
while [[ -n "$dir" && "$dir" != "/" ]]; do
  if [[ -f "$dir/main.tex" ]]; then
    root="$dir"
    break
  fi
  dir="$(dirname "$dir")"
done

[[ -n "$root" ]] || exit 0

cd "$root" || exit 0
FLAGS="${LATEXMK_FLAGS:--lualatex}"
latexmk $FLAGS -interaction=nonstopmode main.tex 2>&1 | tail -5

exit 0
