N_INCLUDE_MIN = 0
N_INCLUDE_MAX = 10

PARTS_SUB_DIR = parts/sub

compile:
	latexmk

common:
	touch main.bib; mkdir sub; mkdir fig;

# Basic
book: common
	@./generate.sh book > main.tex
	@mkdir -p sub/part1/chapter1
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/book.tex  sub/part1/chapter1/section$$i.tex; done

report: common
	@./generate.sh report > main.tex
	@mkdir sub/chapter1
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/report.tex sub/chapter1/section$$i.tex; done

article: common
	@./generate.sh article > main.tex
	@mkdir sub/part1
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/article.tex sub/part1/section$$i.tex; done

# For Japanese Documents
ltjsbook: common
	@./generate.sh ltjsbook > main.tex
	@mkdir -p sub/part1/chapter1
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/book.tex sub/part1/chapter1/section$$i.tex; done

ltjsreport: common
	@./generate.sh ltjsreport > main.tex
	@mkdir sub/chapter1
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/report.tex sub/chapter1/section$$i.tex; done

ltjsarticle: common
	@./generate.sh ltjsarticle > main.tex
	@mkdir sub/part1
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/article.tex sub/part1/section$$i.tex; done

# For Slides
beamer: common
	@./generate.sh beamer > main.tex
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/beamer.tex sub/section$$i.tex; done

# For REVTeX
revtex: common
	@./generate.sh revtex > main.tex
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do cp $(PARTS_SUB_DIR)/revtex.tex sub/section$$i.tex; done