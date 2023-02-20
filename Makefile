.PHONY: all
all: README.html handout.pdf

README.html: README.adoc handout.png
	asciidoctor $<

handout.png: handout.odt schematic.svg
	libreoffice --headless --convert-to png $<

handout.pdf: handout.odt schematic.svg
	faketime -f "2000-01-01 00:00:01" libreoffice --headless --convert-to pdf:writer_web_pdf_Export $<

KiCad_handout_schematic.svg: handout_schematic/KiCad_handout_schematic.kicad_sch
	faketime -f "1970-01-01 00:00:01" kicad-cli sch export svg --black-and-white --no-background-color --exclude-drawing-sheet $<

schematic.svg: KiCad_handout_schematic.svg
	inkscape -D $< -o schematic.svg

.PHONY: clean
clean:
	rm -f *.html KiCad_handout_schematic.svg

.PHONY: cleanall
cleanall: clean
	rm -f *.png *.svg
