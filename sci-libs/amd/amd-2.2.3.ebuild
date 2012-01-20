# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/amd/amd-2.2.3.ebuild,v 1.1 2012/01/20 05:51:11 bicatali Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes
inherit autotools-utils fortran-2

MY_PN=AMD

DESCRIPTION="Library to order a sparse matrix prior to Cholesky factorization"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/amd"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc static-libs"

RDEPEND="virtual/fortran
	sci-libs/ufconfig"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}"

PATCHES=( "${FILESDIR}"/${PN}-2.2.0-autotools.patch )
DOCS=( README.txt Doc/ChangeLog )

src_install() {
	autotools-utils_src_install
	use doc && doins Doc/AMD_UserGuide.pdf
}
