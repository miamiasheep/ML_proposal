.PHONY: main fromscratch dvi ps pdf bibs xfigs compact clean tar tgz

TEXFILE    = template

LATEX      = latex
BIBTEX     = bibtex
MAKEINDEX  = makeindex
DVIPS      = dvips -t letter
PDFLATEX   = pdflatex
PS2PDF     = ps2pdf
XFIGDIR     = xfigs
CURRENTDIR = `basename "\`pwd\`"`

default: pdf

#fromscratch: xfigs
fromscratch:
	$(LATEX) $(TEXFILE)
#	$(BIBTEX) $(TEXFILE)
	$(LATEX) $(TEXFILE)
	$(LATEX) $(TEXFILE)
	$(DVIPS) $(TEXFILE).dvi -o $(TEXFILE).ps

dvi:
	$(LATEX) $(TEXFILE)

ps: dvi
	$(DVIPS) $(TEXFILE).dvi -o $(TEXFILE).ps

pdf:
	$(PDFLATEX) $(TEXFILE)
	$(PDFLATEX) $(TEXFILE)
	$(BIBTEX) $(TEXFILE)
	$(PDFLATEX) $(TEXFILE)
	$(PDFLATEX) $(TEXFILE)
#pdf: ps
#$(PS2PDF) $(TEXFILE)

bibs:
	$(BIBTEX) $(TEXFILE)

xfigs:
	(cd $(FIGDIR); bash ./makefigs ../*.tex )

compact:
#	(rm -f *.aux *.log *.blg *.out *.toc $(TEXFILE).bbl)
	(rm -f *.aux *.log *.blg *.out *.toc)

clean: compact
#	(rm -f *.dvi *.ps *.pdf $(FIGDIR)/*.{eps,pdf,pstex,pstex_t,fig.bak} )
	(rm -f *.dvi *.ps *.pdf $(TEXFILE).bbl $(FIGDIR)/*.{eps,pdf,pstex,pstex_t,fig.bak} )

tar:
	rm -f ../$(CURRENTDIR).tar.gz
	tar cvf ../$(CURRENTDIR).tar ../$(CURRENTDIR)
	gzip ../$(CURRENTDIR).tar
	echo "Created ../$(CURRENTDIR).tar.gz"

tgz:
	rm -f ../$(CURRENTDIR).tgz
	tar cvfz ../$(CURRENTDIR).tgz ../$(CURRENTDIR)
	echo "Created ../$(CURRENTDIR).tgz"

