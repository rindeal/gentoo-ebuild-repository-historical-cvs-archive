# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgagent/pgagent-3.2.1.ebuild,v 1.1 2012/04/28 18:34:11 titanofold Exp $

EAPI="4"

inherit cmake-utils eutils wxwidgets

MY_PN=${PN/a/A}

KEYWORDS="~x86 ~amd64"

DESCRIPTION="${MY_PN} is a job scheduler for PostgreSQL"
HOMEPAGE="http://www.pgadmin.org/download/pgagent.php"
SRC_URI="mirror://postgresql/pgadmin3/release/${PN}/${MY_PN}-${PV}-Source.tar.gz"
LICENSE="POSTGRESQL"
SLOT="0"
IUSE=""

RDEPEND=">=dev-db/postgresql-base-8.3.0
		 x11-libs/wxGTK:2.8
"
DEPEND="${RDEPEND}
		>=dev-util/cmake-2.6
"

S="${WORKDIR}/${MY_PN}-${PV}-Source"

src_prepare() {
	sed -e "s:share):share/${P}):" \
		-i CMakeLists.txt || die "Couldn't patch CMakeLists.txt"
}

src_configure() {
	WX_GTK_VER="2.8"
	if has_version "x11-libs/wxGTK[X]"; then
		need-wxwidgets unicode
	else
		need-wxwidgets base-unicode
	fi
	mycmakeargs="-DSTATIC_BUILD:BOOLEAN=FALSE"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	newinitd "${FILESDIR}/pgagent.initd" ${PN}
	newconfd "${FILESDIR}/pgagent.confd" ${PN}

	rm "${ED}"/usr/{LICENSE,README} || die "Failed to remove useless docs"
}
