# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gom/gom-0.29.103-r1.ebuild,v 1.12 2004/04/22 08:19:45 eradicator Exp $

IUSE=""

DESCRIPTION="Console Mixer Program for OSS"
SRC_URI="http://www.Fh-Worms.DE./~inf222/code/c/gom/released/${P}.tar.gz"
HOMEPAGE="http://www.fh-worms.de/~inf222"

DEPEND=">=sys-libs/ncurses-5.2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	econf || die
	make CFLAGS="${CFLAGS}" || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS NEWS ChangeLog README
	docinto examples
	dodoc README
	docinto examples/default
	dodoc examples/default/*
	docinto examples/standard
	dodoc examples/standard/*
	docinto examples/two-mixers
	dodoc examples/two-mixers/*
}
