# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tleenx2/tleenx2-20040214.ebuild,v 1.5 2005/07/31 21:30:36 swegener Exp $

IUSE=""
LICENSE="GPL-2"

MY_P="TleenX2-${PV}"

DESCRIPTION="A client for Polish Tlen.pl instant messenging system."
HOMEPAGE="http://tleenx.sourceforge.net/"
SRC_URI="mirror://sourceforge/tleenx/${MY_P}.tar.gz"
SLOT="0"
KEYWORDS="x86"
S="${WORKDIR}/${MY_P}"

DEPEND="net-libs/libtlen
	>=x11-libs/gtk+-2.0"

src_install() {
	einstall
	dodoc doc/* AUTHORS BUGS TODO
}
