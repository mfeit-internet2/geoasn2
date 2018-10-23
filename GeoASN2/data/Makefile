#
# Makefile for data directory
#


NAME=GeoLite2
URL_BASE := http://geolite.maxmind.com/download/geoip/database

DATA_SETS := City Country ASN

DATA_DIRS := $(DATA_SETS:%=$(NAME)-%)

TARBALLS:= $(DATA_SETS:%=$(NAME)-%.tar.gz)
.PRECOUS: $(TARBALLS)

default: build

%.tar.gz:
	rm -f $@.download
	curl -s -o $@.download $(URL_BASE)/$@
	mv -f $@.download $@
TO_CLEAN += $(TARBALLS:%=%.download)
TO_DISTCLEAN += $(TARBALLS)

$(NAME)-%: $(NAME)-%.tar.gz
	mkdir -p $@
	tar xzf $<
	rm -rf $@
	mv $@_* $@
TO_CLEAN += $(DATA_DIRS) $(DATA_DIRS)_*


build: $(DATA_DIRS)
	for DB in $(DATA_SETS) ; \
	do \
		rm -f "$${DB}.mmdb" ; \
		ln -s "$(NAME)-$${DB}/$(NAME)-$${DB}.mmdb" . ; \
	done
TO_CLEAN += $(DATA_SETS:%=$(NAME)-%.mmdb)


clean:
	rm -rf $(TO_CLEAN) *~

distclean: clean
	rm -rf $(TO_DISTCLEAN)
