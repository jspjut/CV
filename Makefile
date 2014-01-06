all: CV.html CV.pdf

SRC=$(wildcard src/*.md)
HTML=$(SRC:.md=.html)

CV.html: $(HTML)
	@echo "NYI"

CV.pdf: CV.html
	@echo "NYI"

src/%.html: src/%.md
	pandoc -t html5 -o $@ $<

