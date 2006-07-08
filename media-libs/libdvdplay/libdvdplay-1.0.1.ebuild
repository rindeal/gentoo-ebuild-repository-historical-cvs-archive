# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdplay/libdvdplay-1.0.1.ebuild,v 1.19 2006/07/08 08:17:33 corsair Exp $

IUSE=""

DESCRIPTION="A simple library designed for DVD-menu navigation"
SRC_URI="http://www.videolan.org/pub/${PN}/${PV}/${P}.tar.bz2"
HOMEPAGE="http://developers.videolan.org/libdvdplay/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ppc ~ppc-macos ppc64 sparc x86"

DEPEND=">=media-libs/libdvdread-0.9.3"

src_compile() {
	econf --enable-shared || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
