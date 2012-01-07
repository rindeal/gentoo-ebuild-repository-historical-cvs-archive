# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sil-abyssinica/sil-abyssinica-1.200.ebuild,v 1.1 2012/01/07 22:37:59 dirtyepic Exp $

EAPI="4"

inherit font

MY_PN="AbyssinicaSIL"

DESCRIPTION="SIL Opentype Unicode fonts for Ethiopic languages"
HOMEPAGE="http://scripts.sil.org/AbyssinicaSIL"
SRC_URI="mirror://gentoo/${MY_PN}${PV}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~ppc-macos ~x86-macos"
IUSE="doc"

DOCS="FONTLOG.txt OFL-FAQ.txt README.txt"
FONT_SUFFIX="ttf"

FONT_S="${WORKDIR}/${MY_PN}-${PV}"
S="${FONT_S}"

src_install() {
	font_src_install
	use doc && dodoc -r "${S}"/documentation
}
