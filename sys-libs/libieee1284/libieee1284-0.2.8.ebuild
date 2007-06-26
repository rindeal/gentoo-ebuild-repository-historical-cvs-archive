# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libieee1284/libieee1284-0.2.8.ebuild,v 1.7 2007/06/26 18:51:52 pylon Exp $

WANT_AUTOMAKE=1.7
WANT_AUTOCONF=2.58

inherit autotools eutils

DESCRIPTION="Library to query devices using IEEE1284"
HOMEPAGE="http://cyberelk.net/tim/libieee1284/index.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
		 mirror://gentoo/${P}-dbjh-v4.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~x86"
IUSE="doc"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
		doc? ( app-text/docbook-sgml-utils
		>=app-text/docbook-sgml-dtd-4.1
		app-text/docbook-dsssl-stylesheets
		dev-perl/XML-RegExp )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${DISTDIR}/${P}-dbjh-v4.diff.bz2"
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README* TODO doc/interface*
}
