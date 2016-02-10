#! /bin/sh

# Use this script to bootstrap your build AFTER checking it out from
# source control. You should not have to use it for anything else.

# Runs autoconf, autoheader, aclocal, automake, autopoint, libtoolize
echo "Regenerating autotools files"
aclocal \
&& automake --add-missing \
&& autoconf

echo "Now run ./configure, make, and make install."
