# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klinkstatus/klinkstatus-4.2.4.ebuild,v 1.1 2009/06/04 12:48:05 alexxy Exp $

EAPI="2"
KMNAME="kdewebdev"
inherit kde4-meta

DESCRIPTION="KDE web development - link validity checker"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug +handbook tidy"

DEPEND="
	>=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=]
	tidy? ( app-text/htmltidy )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_KdepimLibs=ON
		$(cmake-utils_use_with tidy LibTidy)"

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	echo
	elog "To use scripting in ${PN}, install dev-lang/ruby."
	echo
}
