# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/kuroo4/kuroo4-0.90.2.ebuild,v 1.1 2012/08/03 17:59:02 johu Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Grophical Portage frontend based on KDE4/Qt4"
HOMEPAGE="http://kuroo.sourceforge.net/"
SRC_URI="mirror://sourceforge/kuroo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="app-portage/gentoolkit
	dev-db/sqlite
	$(add_kdebase_dep kdesu)
	$(add_kdebase_dep kompare)"
RDEPEND="${DEPEND}"
