# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Per Wigren <wigren@home.se>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/psemu-cdr/psemu-cdr-1.62.ebuild,v 1.1 2002/06/03 02:53:20 rphillips Exp $

DESCRIPTION="PSEmu plugin to read from CD-ROM"
HOMEPAGE="http://www.pcsx.net"
LICENSE="GPL-2"
SRC_URI="http://linux.pcsx.net/downloads/plugins/cdr-${PV}.tgz"
DEPEND="x11-libs/gtk+"
S=${WORKDIR}

src_compile() {
	cd src
	( echo CFLAGS = ${CFLAGS}
	  sed 's/CFLAGS =/CFLAGS +=/' < Makefile ) >Makefile.gentoo
	emake -f Makefile.gentoo
}

src_install () {
	insinto /usr/lib/psemu/plugins/
	doins src/libcdr-*
	chmod 755 ${D}/usr/lib/psemu/plugins/*
	dodoc ReadMe.txt
}

