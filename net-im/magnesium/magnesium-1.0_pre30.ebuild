# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/magnesium/magnesium-1.0_pre30.ebuild,v 1.2 2004/06/24 22:56:36 agriffis Exp $

MY_P=${PN}-${PV/1.0_/}
DESCRIPTION="Curphoo X (Magnesium) is a Yahoo chat client."
HOMEPAGE="http://members.iinet.net.au/~texascm/mg/"
SRC_URI="http://members.iinet.net.au/~texascm/mg/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=gnome-base/libglade-2*
	=dev-python/pygtk-2*"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	mv ui.py ui.py.in && sed "s,curphoo.glade,/usr/lib/${P}/curphoo.glade,g" <ui.py.in >ui.py
}

src_compile() {
	einfo "Skipping compilation"
}

src_install() {
	insinto /usr/lib/${P}
	doins *.py curphoo.glade
	chmod +x ${D}/usr/lib/${P}/mg.py
	sed "s,@MAGNESIUMPATH@,${P},g" <${FILESDIR}/magnesium >magnesium || die
	dobin magnesium
	dodoc gpl.txt README CREDITS AUTHORS CHANGELOG COPYING ChangeLog NEWS
}
