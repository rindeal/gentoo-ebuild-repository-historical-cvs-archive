# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dclib/dclib-0.2.16.ebuild,v 1.4 2003/11/14 20:09:35 seemant Exp $

inherit gcc eutils

DESCRIPTION="Library for the Qt client for DirectConnect"
HOMEPAGE="http://dc.ketelhot.de/"
SRC_URI="http://download.berlios.de/dcgui/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=">=app-arch/bzip2-1.0.2
	>=dev-libs/libxml2-2.4.22"

src_unpack() {
	unpack ${A}
	cd ${S}

	[ `gcc-major-version` == 2 ] && epatch ${FILESDIR}/${P}-gcc2.patch
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
