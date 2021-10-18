#
# Makefile for MaxMind and RIR data
#

default: build

SUBDIRS := \
	maxmind \
	rir

build:
	set -e && for DIR in $(SUBDIRS) ; do $(MAKE) -C "$$DIR" ; done

clean:
	set -e && for DIR in $(SUBDIRS) ; do $(MAKE) -C "$$DIR" $@ ; done
