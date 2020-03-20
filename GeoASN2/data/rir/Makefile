#
# Makefile for RIR data directory
#

default: build

CURL := curl -s

NICS := \
        apnic \
        afrinic \
        arin \
        lacnic \
        ripencc

NICFILES := $(NICS:%=delegated-%-extended-latest)


# Each file has a slightly different path at the NIC, hence the custom
# versions

delegated-apnic-extended-latest:
	$(CURL) -o $@ https://ftp.apnic.net/stats/apnic/delegated-apnic-extended-latest

delegated-afrinic-extended-latest:
	$(CURL) -o $@ https://ftp.afrinic.net/pub/stats/afrinic/delegated-afrinic-extended-latest

delegated-arin-extended-latest:
	$(CURL) -o $@ https://ftp.arin.net/pub/stats/arin/delegated-arin-extended-latest

delegated-lacnic-extended-latest:
	$(CURL) -o $@ https://ftp.lacnic.net/pub/stats/lacnic/delegated-lacnic-extended-latest

delegated-ripencc-extended-latest:
	$(CURL) -o $@ https://ftp.ripe.net/ripe/stats/delegated-ripencc-extended-latest

TO_CLEAN += $(NICFILES)


RIRDATA := rirdata
$(RIRDATA): $(NICFILES)
	sed -e '/^#/d' $(NICFILES) \
	| awk '-F|' '$$3 == "asn" && $$7 ~ "(allocated|assigned)" { printf "%d|%s|%s\n", $$4, $$1, $$2 }' \
	| sort -n \
	| uniq \
	> $@
TO_CLEAN += $(RIRDATA)


ASNRAW := ip2asn-combined.tsv.gz
$(ASNRAW):
	curl https://iptoasn.com/data/$(ASNRAW) > "$@"
TO_CLEAN += $(ASNRAW)

ASNDATA := asndata
$(ASNDATA): $(ASNRAW)
	zcat "$<" \
	| awk "-F\t" '{ print $$3 "|" $$5 }' \
	| sort -n \
	| uniq \
	> "$@"
TO_CLEAN += $(ASNDATA)


COMBINED := combined
$(COMBINED): $(ASNDATA) $(RIRDATA)
	./combine $(ASNDATA) $(RIRDATA) > "$@"
TO_CLEAN += $(COMBINED)


DATABASE := asnumber.sqlite
$(DATABASE): $(COMBINED)
	sed -e 's/__FILE__/$^/' database.sql \
	| sqlite3 "$@"
TO_CLEAN += $(DATABASE)


build: $(DATABASE)


clean:
	rm -rf $(TO_CLEAN) *~
