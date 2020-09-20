.SUFFIXES: .tex .dvi .ps .fig .eps .gnu .c
PDF = ps2pdf -dMaxSubsetPct=100 -dCompatibilityLevel=1.2 -dSubsetFonts=true -dEmbedAllFonts=true
CFLAGS  =  -Wall -g -Os -march=i686 -mpreferred-stack-boundary=2 -I/usr/local/include
CC =	gcc
LDFLAGS = -lm
.c:
	$(CC) -o $@ $(CFLAGS) $< $(LDFLAGS)


all: 	paper cleanother


paper: paper.tex
	pdflatex --shell-escape paper
	pdflatex paper
	cp paper.pdf next.pdf

#	scp paper.pdf nescafe:~/Desktop/CN18-paper.pdf
#	gnome-open paper.pdf >out.out 2>err.err 

#	bibtex paper


#	dvips -Pdownload35 -t letter -o paper.ps paper.dvi
#	$(PDF) paper.ps

#	bash -c 'if [[ -f .Zheng ]]; then acroread paper.pdf; else ggv paper.ps; fi'
#	dvips -Pcmz  -t letter -o paper.ps paper.dvi
#	dvips -Pcmz  -t letter -o paper.ps paper.dvi
#	bibtex paper
#	sed -e 's/\(\\begin{thebibliography}{.*}\$\)/\1\\medskip/g' paper.bbl > paper.bbl.mv && mv paper.bbl.mv paper.bbl

bib:	
	pdflatex paper
	bibtex paper
	bibtex paper
	pdflatex paper

sub:
	./submit.sh

aj: all 
	scp next.pdf min.ecn.purdue.edu:/home/min/a/ajajoo/figuresToDisplay/
	#scp next.pdf nescafe:~/Desktop/nextPaper.pdf
	#scp esys20.pdf nescafe:~/Desktop/ESYS20-paper.pdf
	#scp socc19.pdf nescafe:~/Desktop/SOCC19-paper.pdf
	#scp atc19.pdf sp13:~/Desktop/ATC19-paper.pdf

clean: cleanother cleanbib
	rm -rRf *.pdf

cleanother:
	rm -rRf *.dvi *.aux *.blg *.log *.ps *~ paper.out

cleanbib:
	rm -rRf *.bbl

cleanotherandout: cleanother cleanout

cleanmajor: clean cleanout

cleanout:
	rm -rRf *.out

fresh : clean bib paper

freshaj : fresh
	scp next.pdf nescafe:~/Desktop/nextPaper.pdf
	#scp socc19.pdf nescafe:~/Desktop/SOCC19-paper.pdf
	#scp atc19.pdf sp13:~/Desktop/ATC19-paper.pdf
