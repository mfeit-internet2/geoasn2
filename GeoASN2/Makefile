#
# GeoASN2 Makefile
#

# Build 'data' first so the test target in 'bin' has something to work
# with.
SUBDIRS=\
	appserver \
	data \
	bin \
	default \
	metadata

# We have a "default" directory, hence the weird name.
defaultt:
	set -e ; \
	for DIR in $(SUBDIRS); do \
		$(MAKE) -C "$$DIR"; \
	done

update:
	$(MAKE) -C data update

clean:
	set -e ; \
	for DIR in $(SUBDIRS); do \
		$(MAKE) -C "$$DIR" $@; \
	done
	rm -rf *~
