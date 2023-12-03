INKSCAPE ?= inkscape
OPENSCAD ?= openscad

.PHONY: all
all:

.PHONY: clean
clean:
	rm -rf views/
	rm -f image.png

image.png: H0DutchVintageMailbox.scad all_views
	$(OPENSCAD) $< -o $@
all: image.png

.PHONY: all_views
all_views: views/BaseFront.svg
all_views: views/BaseSide.svg
all_views: views/Top.svg
all_views: views/Roof.svg
all_views: views/TopBanner.svg
all_views: views/MidBanner.svg
all_views: views/BottomBanner.svg
all_views: views/BaseFrontLayer1.svg
all_views: views/BaseFrontLayer2.svg
all: all_views

views/%.svg: Views.svg
	$(INKSCAPE) $< --export-id=$(basename $(notdir $@)) \
		--export-id-only --export-area-page --export-filename=$@
