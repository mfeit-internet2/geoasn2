#
# GeoASN2 Makefile
#

default: test
	@echo "Nothing to do."


#
# Python Modules
#

PYTHON_DIR=./python
CACHE_DIR=$(PYTHON_DIR)/.cache
python:
	mkdir -p python
	pip-3 --no-cache-dir install --root $(PYTHON_DIR) geoip2
TO_CLEAN += $(PYTHON_DIR) $(CACHE_DIR)

# This file is used by the scripts to figure out where to import the pip'd Python module(s).
python-dir: python
	find $(PYTHON_DIR) -name "geoip2" -type d \
		| xargs -r dirname \
		| head -1 \
		| sh -e -c 'read DIR ; cd $$DIR ; pwd' \
		> "$@"
TO_CLEAN += python-dir


#
# Test
#

INPUTS := $(sort $(wildcard *.csv))
TESTS := $(INPUTS:%.csv=%)

test-%: % %.csv %.test
	@echo
	@echo Testing $<:
	./$< < $<.csv > $<.out
	diff $<.test $<.out
	@echo "PASSED"


test: python-dir $(TESTS:%=test-%)
TO_CLEAN += $(TESTS:%=%.out)


#
# Everything Else
#

clean:
	rm -rf $(TO_CLEAN)
	find . -name "*~" | xargs -r rm -f
