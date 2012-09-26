# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pugixml/pugixml-1.2.ebuild,v 1.3 2012/09/26 01:22:04 naota Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Light-weight, simple, and fast XML parser for C++ with XPath support"
HOMEPAGE="http://pugixml.org/"
SRC_URI="http://pugixml.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

S=${WORKDIR}/scripts

PATCHES=( "${FILESDIR}"/${P}-cmake.patch )

src_configure() {
	local mycmakeargs=( -DBUILD_SHARED_LIBS=ON )
	cmake-utils_src_configure
}
