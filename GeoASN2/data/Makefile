#
# Makefile for MaxMind and RIR data
#

default: build

SUBDIRS := \
	maxmind \
	rir

build:
	for DIR in $(SUBDIRS) ; do $(MAKE) -C "$$DIR" ; done

clean:
	for DIR in $(SUBDIRS) ; do $(MAKE) -C "$$DIR" $@ ; done
