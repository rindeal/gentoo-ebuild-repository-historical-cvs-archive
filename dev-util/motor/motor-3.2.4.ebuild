# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/motor/motor-3.2.4.ebuild,v 1.5 2004/02/22 12:14:37 dholm Exp $

DESCRIPTION="text mode based programming environment for Linux"
HOMEPAGE="http://konst.org.ua/motor/"
SRC_URI="http://konst.org.ua/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE="nls"

DEPEND=">=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING README TODO FAQ ChangeLog
	docinto tutorial
	dohtml -r tutorial/*
}
