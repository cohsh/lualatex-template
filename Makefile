NAME = 'src'

N_INCLUDE_MIN = 0
N_INCLUDE_MAX = 10

SUB_BEAMER = '\documentclass[../main]{subfiles}\n\\begin{document}\n\n\\end{document}'
SUB_ARTICLE = '\documentclass[../../main]{subfiles}\n\\begin{document}\n\n\\end{document}'
SUB_REPORT = '\documentclass[../../main]{subfiles}\n\\begin{document}\n\n\\end{document}'
SUB_BOOK = '\documentclass[../../../main]{subfiles}\n\\begin{document}\n\n\\end{document}'

compile:
	cd $(NAME); latexmk

common:
	mkdir $(NAME);
	@cd $(NAME); touch main.bib; mkdir sub; mkdir fig;
	@cp .latexmkrc $(NAME)/.
	@cp input.lua $(NAME)/.
	@cp .gitignore ${NAME}/.

# Basic
book: common
	@./generate.sh book > $(NAME)/main.tex
	@mkdir -p $(NAME)/sub/part1/chapter1
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do echo $(SUB_BOOK) > $(NAME)/sub/part1/chapter1/section$$i.tex; done

report: common
	@./generate.sh report > $(NAME)/main.tex
	@mkdir $(NAME)/sub/chapter1
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do echo $(SUB_REPORT) > $(NAME)/sub/chapter1/section$$i.tex; done

article: common
	@./generate.sh article > $(NAME)/main.tex
	@mkdir $(NAME)/sub/part1
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do echo $(SUB_ARTICLE) > $(NAME)/sub/part1/section$$i.tex; done

# For Japanese Documents
ltjsbook: common
	@./generate.sh ltjsbook > $(NAME)/main.tex
	@mkdir -p $(NAME)/sub/part1/chapter1
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do echo $(SUB_BOOK) > $(NAME)/sub/part1/chapter1/section$$i.tex; done

ltjsreport: common
	@./generate.sh ltjsreport > $(NAME)/main.tex
	@mkdir $(NAME)/sub/chapter1
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do echo $(SUB_REPORT) > $(NAME)/sub/chapter1/section$$i.tex; done

ltjsarticle: common
	@./generate.sh ltjsarticle > $(NAME)/main.tex
	@mkdir $(NAME)/sub/part1
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do echo $(SUB_ARTICLE) > $(NAME)/sub/part1/section$$i.tex; done

# For Slides
beamer: common
	@./generate.sh beamer > $(NAME)/main.tex
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do echo $(SUB_BEAMER) > $(NAME)/sub/section$$i.tex; done

clean:
	rm -rf $(NAME)