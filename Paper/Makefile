all: pdf sup1 sup2 clean

pdf: pfors.Rnw bibliography.bib apalikedoiurl.bst
	R -e "knitr::knit2pdf('pfors.Rnw')"

sup1: pfors-sup1.Rnw bibliography.bib apalikedoiurl.bst
	R -e "knitr::knit2pdf('pfors-sup1.Rnw')"

sup2: pfors-sup2.Rnw bibliography.bib apalikedoiurl.bst
	R -e "knitr::knit2pdf('pfors-sup2.Rnw')"

clean:  
	-rm pfors.tex pfors-sup1.tex pfors-sup2.tex *.aux *.log *.bbl *.out *.brf *.synctex.gz *.toc *.blg
	-rm -r cache/
	-rm -r figure/
	-rm -r .auctex-auto/
