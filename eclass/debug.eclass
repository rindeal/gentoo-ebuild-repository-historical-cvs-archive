# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/debug.eclass,v 1.5 2001/11/16 12:50:41 danarmak Exp $
# This provides functions for verbose output for debugging

# Note: we check whether these settings are set by "if [ "$FOO" ]; then".
# Therefore set them to true/false only - not yes/no or whatever.

# redirect output, unset to disable
# use e.g. /dev/tty.
# todo: add support for logging into a file.
DEBUG_OUTPUT=""

# used internally for output
# redirects output wherever's needed
# in the future might use e* from /etc/init.d/functions.sh if i feel like it
debug-print() {

	[ -n "$DEBUG_OUTPUT" ] || return 0

	while [ "$1" ]; do
		echo "debug: $1" > $DEBUG_OUTPUT
		shift
	done

}

# std message functions

debug-print-function() {
	
	str="now in function $1" 
	shift
	debug-print "$str, parameters: $*"

}

debug-print-section() {
	
	debug-print "now in section $*"

}

