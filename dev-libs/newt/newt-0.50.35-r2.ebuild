# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/newt/newt-0.50.35-r2.ebuild,v 1.5 2003/03/28 23:17:43 gmsoft Exp $

S=${WORKDIR}/${P}
DESCRIPTION="redhat's newt windowing toolkit development files"
SRC_URI="http://koto.mynetix.de/gentoo/${P}.tar.gz"
HOMEPAGE="http://www.redhat.com"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc hppa"

DEPEND=">=sys-libs/slang-1.4
	>=dev-libs/popt-1.6"

RDEPEND=""

src_compile() {
	econf || die
	make || die "make failure"
}

src_install () {
	make prefix=${D}/usr install || die "make install failed"
	dodoc CHANGES COPYING peanuts.py popcorn.py tutorial.sgml
	dosym libnewt.so.${PV} /usr/lib/libnewt.so.0.50
}
