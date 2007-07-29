# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/horgand/horgand-1.07.ebuild,v 1.1 2007/07/29 10:43:08 drac Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="horgand is an opensource software organ."
HOMEPAGE="http://personal.telefonica.terra.es/web/soudfontcombi/"
SRC_URI="http://download.berlios.de/horgand/${P}.tar.gz
	mirror://debian/pool/main/h/${PN}/${PN}_${PV}-1.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=x11-libs/fltk-1.1.2
	media-libs/libsndfile
	media-libs/alsa-lib
	media-sound/jack-audio-connection-kit"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${PN}_${PV}-1.diff
	epatch "${FILESDIR}"/${P}-debug.patch
}

src_compile() {
	econf
	emake CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS} $(fltk-config --cxxflags) \
		$(pkg-config --cflags jack) $(pkg-config --cflags sndfile)" || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
	dodir /usr/$(get_libdir)/${PN}
	mv "${D}"/usr/bin/${PN} "${D}"/usr/$(get_libdir)/${PN}/${PN}
	newbin debian/${PN}.wrapper ${PN}
	doman man/${PN}.1
	make_desktop_entry ${PN} Horgand
}
