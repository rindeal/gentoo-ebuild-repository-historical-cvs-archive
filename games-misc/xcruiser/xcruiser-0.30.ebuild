# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/xcruiser/xcruiser-0.30.ebuild,v 1.2 2005/06/15 18:46:31 wolf31o2 Exp $

DESCRIPTION="Fly about 3D-formed file system"
HOMEPAGE="http://xcruiser.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	xmkmf -a
	emake || die "emake failed"
}

src_install() {
	dobin xcruiser || die "dobin failed"
	dodoc CHANGES README README.jp TODO
	newman xcruiser.man xcruiser.1
}
