# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/poster/poster-20060221.ebuild,v 1.3 2011/12/13 23:26:30 ago Exp $

inherit toolchain-funcs

DESCRIPTION="small utility for making a poster from an EPS file or a one-page PS document"
SRC_URI="mirror://kde/printing/${P}.tar.bz2"
HOMEPAGE="http://printing.kde.org/downloads"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

src_compile(){
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} ${PN}.c -lm -o ${PN} || die
}

src_install() {
	dobin ${PN} || die
	doman ${PN}.1
	dodoc README ChangeLog
}
