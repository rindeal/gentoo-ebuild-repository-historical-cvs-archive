# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tleds/tleds-1.05_beta11.ebuild,v 1.8 2003/02/13 13:51:57 vapier Exp $

IUSE="X"

MY_P=${P/_/}
S=${WORKDIR}/${MY_P/eta11/}
DESCRIPTION="Blinks keyboard LEDs indicating outgoing and incoming network packets on selected network interface"
HOMEPAGE="http://www.hut.fi/~jlohikos/tleds/"
SRC_URI="http://www.hut.fi/~jlohikos/tleds/public/${MY_P/11/10}.tgz
	http://www.hut.fi/~jlohikos/tleds/public/${MY_P}.patch.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="X? ( virtual/x11 )"

src_unpack() {
	unpack tleds-1.05beta10.tgz
	cd ${S}
	bzcat ${DISTDIR}/${MY_P}.patch.bz2 | patch  || die
	patch < ${FILESDIR}/${P}-gentoo.patch || die
}

src_compile() {
	if [ `use X` ] ; then
		emake all || die "make failed :("
	else
		emake tleds || die "make tleds failed :("
	fi
}

src_install() {
	dosbin tleds
	use X && dosbin xtleds

	doman tleds.1
	dodoc README COPYING Changes
}
