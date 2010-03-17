# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevplatform/kdevplatform-0.9.95.ebuild,v 1.7 2010/03/17 17:07:35 sping Exp $

EAPI="2"

inherit kde4-base versionator

KDEVELOP_PV="$(($(get_major_version)+3)).$(get_after_major_version)"
DESCRIPTION="KDE development support libraries and apps"
HOMEPAGE="http://www.kdevelop.org/"
SRC_URI="mirror://kde/unstable/kdevelop/${KDEVELOP_PV}/src/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 ~hppa ppc ppc64 x86"
SLOT="4"
# Moved to playground for now
# bazaar
IUSE="cvs debug git mercurial subversion"

DEPEND="
	>=dev-libs/boost-1.35.0
	subversion? ( >=dev-util/subversion-1.3 )
"
# Moved to playground for now
# bazaar? ( dev-util/bzr )
RDEPEND="${DEPEND}
	cvs? ( dev-util/cvs )
	git? ( dev-vcs/git )
	mercurial? ( dev-vcs/mercurial )
"

# Moved to playground for now
# $(cmake-utils_use_build bazaar)
src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_build cvs)
		$(cmake-utils_use_build git)
		$(cmake-utils_use_build mercurial)
		$(cmake-utils_use_build subversion)
		$(cmake-utils_use_with subversion SubversionLibrary)"

	kde4-base_src_configure
}
