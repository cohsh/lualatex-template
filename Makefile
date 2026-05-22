N_INCLUDE_MIN = 0
N_INCLUDE_MAX = 10

PARTS_SUB_DIR = parts/sub

# Build artifacts produced by latexmk / lualatex
ARTIFACTS = main.aux main.bbl main.blg main.dvi main.fdb_latexmk main.fls \
            main.log main.nav main.out main.pdf main.snm main.synctex.gz main.toc

# Document layout. The default uses subfiles; `make <class>-single` (see the
# pattern rule below) sets SINGLE=1 to generate a single-file document instead.
GEN_MODE = $(if $(SINGLE),single,subfiles)

.PHONY: compile common clean distclean \
        book report article ltjsbook ltjsreport ltjsarticle beamer revtex

compile:
	latexmk

common:
	@touch main.bib; mkdir -p fig;

# Remove build artifacts only (your document sources are kept)
clean:
	rm -rf cache
	rm -f $(ARTIFACTS)

# Remove every generated file and return to the pristine template state.
# WARNING: this deletes main.tex, main.bib and everything under sub/ and fig/.
distclean: clean
	rm -f main.tex main.bib
	rm -rf sub fig

# Single-file variant of any class target: `make article-single`, etc.
%-single:
	@$(MAKE) --no-print-directory $* SINGLE=1

# Basic
book: common
	@./generate.sh book $(GEN_MODE) > main.tex
	$(if $(SINGLE),,@mkdir -p sub/part1/chapter1; for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/book.tex sub/part1/chapter1/section$$i.tex; done)

report: common
	@./generate.sh report $(GEN_MODE) > main.tex
	$(if $(SINGLE),,@mkdir -p sub/chapter1; for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/report.tex sub/chapter1/section$$i.tex; done)

article: common
	@./generate.sh article $(GEN_MODE) > main.tex
	$(if $(SINGLE),,@mkdir -p sub/part1; for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/article.tex sub/part1/section$$i.tex; done)

# For Japanese Documents
ltjsbook: common
	@./generate.sh ltjsbook $(GEN_MODE) > main.tex
	$(if $(SINGLE),,@mkdir -p sub/part1/chapter1; for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/book.tex sub/part1/chapter1/section$$i.tex; done)

ltjsreport: common
	@./generate.sh ltjsreport $(GEN_MODE) > main.tex
	$(if $(SINGLE),,@mkdir -p sub/chapter1; for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/report.tex sub/chapter1/section$$i.tex; done)

ltjsarticle: common
	@./generate.sh ltjsarticle $(GEN_MODE) > main.tex
	$(if $(SINGLE),,@mkdir -p sub/part1; for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/article.tex sub/part1/section$$i.tex; done)

# For Slides
beamer: common
	@./generate.sh beamer $(GEN_MODE) > main.tex
	$(if $(SINGLE),,@mkdir -p sub; for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/beamer.tex sub/section$$i.tex; done)

# For REVTeX
revtex: common
	@./generate.sh revtex $(GEN_MODE) > main.tex
	$(if $(SINGLE),,@mkdir -p sub; for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/revtex.tex sub/section$$i.tex; done)
