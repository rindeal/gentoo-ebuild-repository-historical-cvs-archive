# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fluxconf/fluxconf-0.9.4.ebuild,v 1.1 2003/06/01 21:30:20 mholzer Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Configuration editor for fluxbox"
SRC_URI="http://devaux.fabien.free.fr/flux/${P}.tar.gz"
HOMEPAGE="http://devaux.fabien.free.fr/flux/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die
	rm ${D}/usr/bin/fluxkeys ${D}/usr/bin/fluxmenu

	dosym /usr/bin/fluxconf /usr/bin/fluxkeys
	dosym /usr/bin/fluxconf /usr/bin/fluxmenu
	
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
