INKSCAPE := inkscape

all: all_views

clean:
	rm -r views/

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

views/%.svg: Views.svg
	$(INKSCAPE) $< --export-id=$(basename $(notdir $@)) \
		--export-id-only --export-area-page --export-filename=$@
