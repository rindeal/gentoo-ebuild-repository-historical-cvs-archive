# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/sumika/sumika-0.02.01.ebuild,v 1.2 2003/10/07 00:20:24 usata Exp $

IUSE="nls"

MY_P="${PN}-${PV%.*}"

DESCRIPTION="Sumika is a management utility for dictionaries of Anthy, SKK, Canna and PRIME"
HOMEPAGE="http://sumika.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/5714/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

S="${WORKDIR}/${MY_P}"

DEPEND="virtual/glibc
	>=x11-libs/gtk+-2.2
	>=dev-libs/glib-2.2
	canna? ( app-i18n/canna
		<app-i18n/canna-3.6_p4 )
	nls? ( sys-devel/gettext )"

src_compile() {

	econf `use_enable nls` || die
	emake || die
}

src_install() {

	einstall || die

	# we have our own place for docs
	dodir /usr/share/doc
	mv ${D}/usr/doc/${PN} ${D}/usr/share/doc/${PF}
}
