#
# Makefile for GeoASN2 Programs
#

default:
	@echo "Nothing to do here."


PROGRAMS=asn2 asnumber ga2 geo2 geoasn2

TO_CLEAN += data

test: run-tests
	./run-tests | ([ -t 1 ] && less || cat)


clean:
	rm -rf $(TO_CLEAN) *~
