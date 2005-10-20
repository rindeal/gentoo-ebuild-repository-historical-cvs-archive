# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/radvd/files/radvd-0.9-conf.d,v 1.1 2005/10/20 12:55:05 brix Exp $

# Extra options to pass to radvd
OPTIONS=""

# Set this to "no" to tell the init script NOT to set up IPv6 forwarding
# using /proc/sys/net/ipv6/conf/all/forwarding
# Only change this if you know what you're doing!
FORWARD="yes"
