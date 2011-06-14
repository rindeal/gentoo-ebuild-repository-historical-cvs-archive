# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/quvi/quvi-0.2.15.ebuild,v 1.3 2011/06/14 19:03:12 maekke Exp $

EAPI=4

DESCRIPTION="library for parsing video download links"
HOMEPAGE="http://quvi.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV:0:3}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="doc examples test offensive static-libs"

RDEPEND=">=net-misc/curl-7.18.0
	dev-lang/lua[deprecated]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# tests fetch data from live websites, so it's rather normal that they
# will fail
RESTRICT="test"

src_configure() {
	econf \
		--without-doc \
		$(use_enable examples) \
		$(use_enable offensive nsfw) \
		$(use_enable static-libs static)
}

src_install() {
	default
	use doc && dodoc doc/How*
	find "${D}" -name '*.la' -delete
}
