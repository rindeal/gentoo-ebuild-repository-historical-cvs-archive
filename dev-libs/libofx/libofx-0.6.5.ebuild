# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libofx/libofx-0.6.5.ebuild,v 1.2 2004/01/09 20:27:59 agriffis Exp $

DESCRIPTION="Library to support the Open Financial eXchange XML Format"
HOMEPAGE="http://libofx.sourceforge.net/"
SRC_URI="mirror://sourceforge/libofx/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc alpha"
IUSE=""
DEPEND=">=app-text/opensp-1.5
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}


	# because we redefine docdir in src_install, we need to make sure the
	# dtd's go to the right place, LIBOFX_DTD_DIR
	cd ${S}/dtd
	sed -i -e 's/$(DESTDIR)$(docdir)/$(DESTDIR)$(LIBOFX_DTD_DIR)/g' \
		Makefile.in
}
src_compile() {
	econf
	emake || die
}

src_install() {
	dodir /usr/share/doc/${PF}
	einstall docdir=${D}/usr/share/doc/${PF} || die
}
