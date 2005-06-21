# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mlmmj/mlmmj-1.2.8.ebuild,v 1.1 2005/06/21 19:42:34 lcars Exp $

inherit eutils

MY_PV="${PV/_rc/-RC}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Mailing list managing made joyful"
HOMEPAGE="http://mlmmj.mmj.dk/"
SRC_URI="http://mlmmj.mmj.dk/files/${MY_P}.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc-macos ~amd64"
IUSE=""
DEPEND="virtual/mta"
#RDEPEND=""
S="${WORKDIR}/${MY_P}"
SHAREDIR="/usr/share/mlmmj"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodir ${SHAREDIR}
	dodir ${SHAREDIR}/texts
	insinto ${SHAREDIR}/texts
	doins listtexts/*

	dodoc AUTHORS ChangeLog COPYING FAQ LICENSE README
	dodoc TODO TUNABLES UPGRADE VERSION README.access

	insinto /usr/share/mlmmj
	cd ${S}/contrib/web
	doins -r *
}

pkg_postinst() {
	einfo "mlmmj comes with serveral webinterfaces:"
	einfo "- One for user subscribing/unsubscribing"
	einfo "- One for admin tasks"
	einfo "both available in a php and perl module."
	einfo "For more info have a look in /usr/share/mlmmj"
}
