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
	src/skills.html \
	src/publications.html \
	src/students.html \
	src/funding.html \
	src/honors.html \
	src/professional.html \
	src/teaching.html \
	src/games.html \
	src/references.html \

raw.html: $(HTML) src/cv.md
	pandoc -t html5 -o $@ $(addprefix -A , $(filter-out src/cv.html,$(HTML))) src/cv.md

$(CVNAME).html: $(ORDEREDHTML) src/cv.md
	pandoc -t html5 -o $@ $(addprefix -A , $(filter-out src/cv.html,$(ORDEREDHTML))) src/cv.md
#pandoc -s -H src/cv.css -t html5 -o $@ $(addprefix -A , $(filter-out src/cv.html,$(HTML))) src/cv.md

$(CVNAME).pdf: $(CVNAME).html
	pandoc -H src/cv.tex $< -o $@

src/%.html: src/%.md
	pandoc -t html5 -o $@ $<

clean:
	rm $(HTML) 
