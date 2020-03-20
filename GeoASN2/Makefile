#
# Top-Level Makefile for GeoASN2
#

default: update


update:
	$(MAKE) -C data build


test: update
	$(MAKE) -C bin test


clean:
	make -C data clean
	rm -rf $(TO_CLEAN)
	find . -name "*~" | xargs -r rm -f
