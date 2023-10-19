N_INCLUDE_MIN = 0
N_INCLUDE_MAX = 10

SUB_BEAMER = '\documentclass[../main]{subfiles}\n\\begin{document}\n\n\end{document}'
SUB_ARTICLE = '\documentclass[../../main]{subfiles}\n\\begin{document}\n\n\end{document}'
SUB_BOOK = '\documentclass[../../../main]{subfiles}\n\\begin{document}\n\n\end{document}'

compile:
	latexmk

common:
	@touch main.bib
	@mkdir sub

ltjsbook: common
	cp templates/ltjsbook.tex main.tex
	@mkdir sub/part1
	@mkdir sub/part1/chapter1
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do echo $(SUB_BOOK) > sub/part1/chapter1/section$$i.tex; done

ltjsarticle: common
	cp templates/ltjsarticle.tex main.tex
	@mkdir sub/part1
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do echo $(SUB_ARTICLE) > sub/part1/section$$i.tex; done

beamer: common
	cp templates/beamer.tex main.tex
	@for i in `seq $(N_INCLUDE_MIN) $(N_INCLUDE_MAX)`; do echo $(SUB_BEAMER) > sub/section$$i.tex; done

clean:
	rm -f main.*
	rm -rf sub/