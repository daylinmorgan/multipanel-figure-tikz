DPI := 300
FIGURE_NUMS := 1

tex/figure-1.tex: $(addprefix panels/, diller.jpg $(addsuffix .pdf,bevo tower utexas tower-tall))

# -----

svgs: $(foreach num, $(FIGURE_NUMS), figures/figure-$(num).svg)
pngs: $(foreach num, $(FIGURE_NUMS), figures/figure-$(num).png)
pdfs: $(foreach num, $(FIGURE_NUMS), figures/figure-$(num).pdf)

panels/%.pdf: panels/%.svg
	inkscape --export-type=pdf $<

figures/figure-%.pdf: tex/figure-%.tex
	latexmk -pdflua $< -auxdir=.latexmk -outdir=figures

figures/figure-%.svg: figures/figure-%.pdf
	inkscape --export-type=svg --export-plain-svg $<

figures/figure-%.png: figures/figure-%.pdf
	inkscape --export-type=png --export-dpi=$(DPI) $<

clean:
	rm figures/*

.PHONY: svgs pngs pdfs clean
