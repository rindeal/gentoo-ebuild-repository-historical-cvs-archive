# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/x264-svn/x264-svn-20051004.ebuild,v 1.1 2005/10/05 09:36:14 zypher Exp $

inherit eutils

IUSE="X debug threads"

DESCRIPTION="A free libary for encoding X264/AVC streams."
HOMEPAGE="http://developer.videolan.org/x264.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~x86"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-lang/nasm"

S=${WORKDIR}/${PN}

src_compile() {
	./configure \
	`use_enable debug` \
	`use_enable threads pthread` \
	`use_enable X visualize` \
	|| die "configure failed"
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS TODO COPYING
}
