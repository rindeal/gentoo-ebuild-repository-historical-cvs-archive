# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qterm/qterm-0.3.8.ebuild,v 1.2 2004/09/02 22:49:41 pvdabeel Exp $

DESCRIPTION="QTerm is a BBS client in Linux."
HOMEPAGE="http://qterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/qterm/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"
IUSE="ssl"
DEPEND="virtual/x11
	>=media-sound/esound-0.2.22
	kde-base/arts
	dev-lang/python
	ssl? ( dev-libs/openssl )
	>=x11-libs/qt-3.0.0"

src_compile() {

	# yeah, it's --disable-ssh to disable ssl
	econf `use_enable ssl ssh` || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "install faled"
	dodoc AUTHORS BUGS COPYING ChangeLog README* RELEASE_NOTES
}
