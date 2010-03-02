# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpqstego/libpqstego-0.0.1.ebuild,v 1.1 2010/03/02 15:03:57 ssuominen Exp $

EAPI=2

DESCRIPTION="Library for Perturbed Quantization Steganography"
HOMEPAGE="http://sourceforge.net/projects/pqstego/"
SRC_URI="mirror://sourceforge/${PN/lib}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sci-libs/gsl[cblas]"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-static
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS CHANGES README TODO
	find "${D}" -name '*.la' -delete
}
