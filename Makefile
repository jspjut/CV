# make deploy to send to website build path

CVNAME=spjut

all: $(CVNAME).html $(CVNAME).pdf

# Standard pick everything alphabetically CV
SRC=$(wildcard src/*.md)
HTML=$(filter-out src/cv.html,$(SRC:.md=.html))

# Other CV selections
ORDEREDHTML=src/cv.html \
	src/description.html \
	src/research.html \
	src/education.html\
	src/jobs.html \
	src/publications.html \
	src/students.html \
	src/funding.html \
	src/honors.html \
	src/professional.html \
	src/teaching.html \
	src/games.html \
#	src/references.html \
	src/skills.html \

raw.html: $(HTML) src/cv.md
	pandoc -t html5 -o $@ $(addprefix -A , $(filter-out src/cv.html,$(HTML))) src/cv.md

$(CVNAME).html: $(ORDEREDHTML) src/cv.md
	pandoc -t html5 -o $@ $(addprefix -A , $(filter-out src/cv.html,$(ORDEREDHTML))) src/cv.md
#pandoc -s -H src/cv.css -t html5 -o $@ $(addprefix -A , $(filter-out src/cv.html,$(HTML))) src/cv.md

# Convert to pdf from the html
$(CVNAME).pdf: $(CVNAME).html src/cv.tex
	pandoc -s -V colorlinks -H src/cv.tex $< -o $@

src/%.html: src/%.md
	pandoc -t html5 -o $@ $<

clean:
	rm $(HTML) 

# The deploy target is for deploying to my personal website
DEPLOYCVHTML=~/jspjut.github.io/content/cv/_index.html
DEPLOYCVPDF=~/jspjut.github.io/static/files/cv.pdf
deploy: all
	scripts/to-jekyll.py $(CVNAME).html > $(DEPLOYCVHTML)
	cp $(CVNAME).pdf $(DEPLOYCVPDF)

# Publications List (make pubs.pdf)

pubs.html: src/publications.html
	pandoc -t html5 -o $@ $(addprefix -A , $<) src/cv.md

pubs.pdf: pubs.html
	pandoc -H src/plist.tex $< -o $@
