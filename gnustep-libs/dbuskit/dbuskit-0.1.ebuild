# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/dbuskit/dbuskit-0.1.ebuild,v 1.3 2012/02/14 18:37:45 voyageur Exp $

EAPI=4
inherit autotools gnustep-2

DESCRIPTION="framework that interfaces Objective-C applications with the D-Bus IPC service"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="http://download.gna.org/gnustep/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=sys-apps/dbus-1.2.1"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-configure.patch
	if ! use doc; then
		# Remove doc target
		sed -i -e "/SUBPROJECTS/s/Documentation//" GNUmakefile \
			|| die "doc sed failed"
	fi

	eautoreconf
}
