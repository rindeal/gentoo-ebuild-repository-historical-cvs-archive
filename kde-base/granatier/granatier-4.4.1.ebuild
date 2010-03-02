# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/granatier/granatier-4.4.1.ebuild,v 1.1 2010/03/02 15:35:03 tampakrap Exp $

EAPI="3"

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="KDE Bomberman game"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook gluon"

DEPEND="
	gluon? ( media-libs/gluon )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs+="
		$(cmake-utils_use_with gluon)
	"

	kde4-meta_src_configure
}
