# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-kioslaves/kdepim-kioslaves-3.5.10.ebuild,v 1.4 2009/06/06 11:21:30 maekke Exp $

KMNAME=kdepim
KMMODULE=kioslaves

EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdepim-3.5-patchset-04.tar.bz2"

DESCRIPTION="kioslaves from kdepim package"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="sasl"
DEPEND="sasl? ( >=dev-libs/cyrus-sasl-2 )
	>=kde-base/libkmime-${PV}:${SLOT}"

KMCOPYLIB="libkmime libkmime/"
KMEXTRACTONLY="libkmime/"
KMCOMPILEONLY="libemailfunctions"

src_compile() {
	myconf="$myconf $(use_with sasl)"
	kde-meta_src_compile
}
