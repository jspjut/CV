CVNAME=spjut

all: $(CVNAME).html $(CVNAME).pdf

# Standard pick everything alphabetically CV
SRC=$(wildcard src/*.md)
HTML=$(filter-out src/cv.html,$(SRC:.md=.html))

# Other CV selections
#HTML=src/education.html

$(CVNAME).html: $(HTML) src/cv.md
	pandoc -H src/cv.css -t html5 -o $@ $(addprefix -A , $(filter-out src/cv.html,$(HTML))) src/cv.md
#pandoc -s -H src/cv.css -t html5 -o $@ $(addprefix -A , $(filter-out src/cv.html,$(HTML))) src/cv.md

$(CVNAME).pdf: $(CVNAME).html
	pandoc -H src/cv.tex $< -o $@

src/%.html: src/%.md
	pandoc -t html5 -o $@ $<

clean:
	rm $(HTML) 
