# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/preview/preview-0.9.ebuild,v 1.2 2011/12/01 19:35:44 phajdan.jr Exp $

EAPI=3
inherit gnustep-2

S=${WORKDIR}/${PN/p/P}

DESCRIPTION="Simple image viewer."
HOMEPAGE="http://www.sonappart.net/softwares/preview/"
SRC_URI="http://www.sonappart.net/softwares/preview/download/${P/p/P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

src_prepare() {
	# Fix compilation, patch from debian
	epatch "${FILESDIR}"/${PN}-0.8.5-compilation-errors.patch
}
