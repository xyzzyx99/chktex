#!/bin/dash
# -- remember to change this to sh

set -e

usage() {
    echo "$0 BUILDDIR SRCDIR"
}

if [ "x$1" = x ] || [ "x$2" = x ]; then
    usage
fi

builddir="$(cd $1; pwd)"
srcdir="$(cd $2; pwd)"

testsdir="$srcdir/tests"
output="$testsdir/main.out"
expected="$testsdir/main.expected"

check_results() {
    sed -i -e 's~Message 22 in .*tests/~Message 22 in ~;' "$output"
	if cmp -s "$expected" "$output"; then
		echo ">>> OK!"
		rm -f "$output"
        return 0
	else
		echo "***WARNING***";
		echo "Unexpected test output";
		diff -u "$expected" "$output";
        return 1
	fi
}


echo ">>> Testing that inclusion works correctly..."
# absolute path
rm -f "$output"
${builddir}/chktex -mall -r -g0 -l$srcdir/chktexrc -v5 \
           $testsdir/main.tex 2>/dev/null \
          1> $testsdir/main.out
check_results

# relative path
cd "$srcdir"
${builddir}/chktex -mall -r -g0 -l$srcdir/chktexrc -v5 \
           tests/main.tex 2>/dev/null \
	 	  1> tests/main.out
check_results

# file in the same directory
cd "$testsdir"
${builddir}/chktex -mall -r -g0 -l$srcdir/chktexrc -v5 \
           main.tex 2>/dev/null \
	 	  1> main.out
check_results
