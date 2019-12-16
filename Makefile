#
# GeoASN2 Makefile
#

default:
	$(MAKE) -C GeoASN2

%:
	$(MAKE) -C GeoASN2 "$@"
	rm -rf *~
