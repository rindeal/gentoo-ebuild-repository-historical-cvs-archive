# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openmosix-sources/openmosix-sources-2.4.22-r5.ebuild,v 1.1 2004/03/30 16:32:27 tantive Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel

OKV="2.4.22"
[ "${PR}" == "r0" ] && KV=${PV/_/-}-openmosix || KV=${PV/_/-}-openmosix-${PR}
EXTRAVERSION="`echo ${KV}|sed -e 's:[0-9]\+\.[0-9]\+\.[0-9]\+\(.*\):\1:'`"
BASE="`echo ${KV}|sed -e s:${EXTRAVERSION}::`"
S=${WORKDIR}/linux-${KV}

# What's in this kernel?

# INCLUDED:
#   2.4.22, plus:
#   2.4.22  openmosix-2.4.22-3

DESCRIPTION="Full sources for the Gentoo openMosix Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
mirror://sourceforge/openmosix/openMosix-2.4.22-3.bz2"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://www.openmosix.org/"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="-* ~x86"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die
	cd linux-${KV}
	bzcat ${DISTDIR}/openMosix-2.4.22-3.bz2|patch -p1 || die "-openmosix patch failed"

	epatch ${FILESDIR}/do_brk_fix.patch || die "Failed to patch do_brk() vulnerability!"
	epatch ${FILESDIR}/${PN}.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
	epatch ${FILESDIR}/${PN}-2.4.20.munmap.patch || die "Failed to apply munmap patch!"
	epatch ${FILESDIR}/${P}.rtc_fix.patch || die "Failed to patch RTC vulnerabilities!"

	kernel_universal_unpack
}
