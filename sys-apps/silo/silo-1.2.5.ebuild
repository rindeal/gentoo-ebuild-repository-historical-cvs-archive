# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/silo/silo-1.2.5.ebuild,v 1.10 2002/12/09 04:37:26 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="SPARC/UltraSPARC Improved Loader, a boot loader for sparc"
SRC_URI="http://www.ultralinux.nl/silo/download/${P}.tar.bz2"
HOMEPAGE="http://freshmeat.net/projects/silo/index.html"
KEYWORDS="sparc  -x86 -ppc -alpha"

SLOT="0"
LICENSE="GPL-2"
DEPEND="sys-apps/e2fsprogs
	sys-apps/sparc-utils"

src_compile() {
	 make ${MAKEOPTS} || die
}

src_install() {
	 make DESTDIR=${D} install || die
}
