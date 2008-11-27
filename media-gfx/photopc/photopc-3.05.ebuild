# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/photopc/photopc-3.05.ebuild,v 1.12 2008/11/27 22:20:05 jer Exp $

inherit toolchain-funcs

DESCRIPTION="Utility to control digital cameras based on Sierra Imaging firmware"
HOMEPAGE="http://photopc.sourceforge.net"
SRC_URI="mirror://sourceforge/photopc/${P}.tar.gz"

LICENSE="|| ( BSD as-is )"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

src_compile() {
	tc-export CC
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dobin photopc epinfo || die "dobin failed"
	doman photopc.1 epinfo.1
}
