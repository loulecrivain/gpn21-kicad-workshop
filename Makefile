.PHONY: all
all: README.html handout.pdf

README.html: README.adoc handout.png
	asciidoctor README.adoc

handout.png:
	libreoffice --headless --convert-to png handout.odt

handout.pdf:
	libreoffice --headless --convert-to pdf handout.odt

.PHONY: clean
clean:
	rm -f *.html *.png *.pdf
