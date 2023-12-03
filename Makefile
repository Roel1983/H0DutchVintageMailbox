INKSCAPE ?= inkscape
OPENSCAD ?= openscad

SCAD_INPUT ?= H0DutchVintageMailbox.scad
STL_OUTPUT ?= H0DutchVintageMailbox.stl
IMG_OUTPUT ?= image.png

views := $(filter-out layer1, $(shell $(INKSCAPE) --actions="select-all:layers;select-list;" Views.svg | grep "cloned: " | cut -d ' ' -f 1))

.PHONY: all
all:

.PHONY: clean
clean:
	rm -rf views/
	rm -f $(STL_OUTPUT)

.PHONY: H0DutchVintageMailbox
H0DutchVintageMailbox: $(SCAD_INPUT) all_views

all: $(STL_OUTPUT)
$(STL_OUTPUT): H0DutchVintageMailbox
	$(OPENSCAD) $(SCAD_INPUT) -o $@

all: $(IMG_OUTPUT)
image.png: H0DutchVintageMailbox
	$(OPENSCAD) $(SCAD_INPUT) -o $@

.PHONY: all_views
all_views: $(addprefix views/, $(addsuffix .svg, $(views)))
all: all_views

views/%.svg: Views.svg
	$(INKSCAPE) $< --export-id=$(basename $(notdir $@)) \
		--export-id-only --export-area-page --export-filename=$@
