.PHONY: all
all: README.html handout.pdf

README.html: README.adoc handout.png
	asciidoctor README.adoc

handout.png: schematic.svg
	libreoffice --headless --convert-to png handout.odt

handout.pdf: schematic.svg
	libreoffice --headless --convert-to pdf handout.odt

KiCad_handout_schematic.svg: handout_schematic/KiCad_handout_schematic.kicad_sch
	kicad-cli sch export svg --black-and-white --no-background-color --exclude-drawing-sheet handout_schematic/KiCad_handout_schematic.kicad_sch

schematic.svg: KiCad_handout_schematic.svg
	inkscape -D KiCad_handout_schematic.svg -o schematic.svg

.PHONY: clean
clean:
	rm -f *.html KiCad_handout_schematic.svg

.PHONY: cleanall
cleanall: clean
	rm -f *.png *.svg
