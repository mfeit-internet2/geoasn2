#
# Top-Level Makefile for GeoASN2
#

DATA_DEST=bin/data

default: update



data-build:
	$(MAKE) -C data build

$(DATA_DEST):
	mkdir -p "$@"

data-install: data-build $(DATA_DEST)
	cp data/maxmind/*.mmdb data/rir/*.sqlite "$(DATA_DEST)"

update: data-install



test: update
	$(MAKE) -C bin test


clean:
	make -C bin "$@"
	make -C data "$@"
	rm -rf $(TO_CLEAN)
	find . -name "*~" | xargs -r rm -f
