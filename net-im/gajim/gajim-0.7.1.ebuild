# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gajim/gajim-0.7.1.ebuild,v 1.5 2005/06/28 23:01:13 agriffis Exp $

inherit virtualx multilib eutils

DESCRIPTION="Jabber client written in PyGTK"
HOMEPAGE="http://www.gajim.org/"
SRC_URI="http://www.gajim.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~amd64"
IUSE="nls spell"

DEPEND=">=dev-python/pygtk-2.4.0
	>=dev-lang/python-2.3.0
	>=x11-libs/gtk+-2.4
	spell? ( >=app-text/gtkspell-2.0.4 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-multilib.patch
}

src_compile() {
	targets="idle trayicon"
	use nls && targets="${targets} translation"
	use spell && targets="${targets} gtkspell"
	Xemake ${targets} || die "Xmake failed"
}

src_install() {
	Xemake DESTDIR=${D} LIBDIR=$(get_libdir) install || die
	dodoc README AUTHORS COPYING
}
