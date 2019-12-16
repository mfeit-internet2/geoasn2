#
# GeoASN2 Makefile
#

default:
	@echo "Nothing to do."


#
# Test
#

INPUTS := $(wildcard *.csv)
TESTS := $(INPUTS:%.csv=%)

test-%: % %.csv %.test
	@echo
	@echo Testing $<:
	./$< < $<.csv > $<.out
	diff $<.test $<.out
	@echo "PASSED"


test: $(TESTS:%=test-%)
TO_CLEAN += $(TESTS:%=%.out)


#
# Everything Else
#

clean:
	rm -rf $(TO_CLEAN)
	find . -name "*~" | xargs -r rm -f
