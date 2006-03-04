# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mcdp/mcdp-0.4a.ebuild,v 1.1 2006/03/04 07:31:38 matsuu Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A very small console cd player"
HOMEPAGE="http://www.mcmilk.de/projects/mcdp/"
SRC_URI="http://www.mcmilk.de/projects/mcdp/dl/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-dietlibc-fix.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin mcdp || die
	doman mcdp.1 || die

	cd doc
	dodoc AUTHOR BUGS CHANGES README THANKS TODO WISHLIST profile.sh
}
