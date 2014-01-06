CVNAME=spjut

all: $(CVNAME).html $(CVNAME).pdf

SRC=$(wildcard src/*.md)
HTML=$(SRC:.md=.html)

$(CVNAME).html: $(HTML)
	pandoc -s -H src/cv.css --section-divs -f markdown -t html5 -o $@ $(addprefix -A , $(filter-out src/cv.html,$(HTML))) src/cv.md

$(CVNAME).pdf: $(CVNAME).html
	@echo "NYI"

src/%.html: src/%.md
	pandoc -t html5 -o $@ $<

clean:
	rm $(HTML) 
