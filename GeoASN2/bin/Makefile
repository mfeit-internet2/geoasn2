#
# Makefile for GeoASN2 Programs
#

default:
	@echo "Nothing to do here."


PROGRAMS=asn2 asnumber ga2 geo2 geoasn2

test:
	for PROGRAM in $(PROGRAMS) ; \
	do \
		echo ; \
		echo "$${PROGRAM}" ; \
		echo ; \
		"./$${PROGRAM}" < "./$${PROGRAM}.csv" ; \
	done


clean:
	rm -rf $(TO_CLEAN) *~
