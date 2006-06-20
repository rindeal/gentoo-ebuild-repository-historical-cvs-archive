# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gngeo/gngeo-0.6.12.ebuild,v 1.1 2006/06/20 20:28:23 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A NeoGeo emulator"
HOMEPAGE="http://m.peponas.free.fr/gngeo/"
SRC_URI="http://m.peponas.free.fr/gngeo/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND="virtual/opengl
	sys-libs/zlib
	media-libs/sdl-image
	>=media-libs/libsdl-1.2"
# gcc-3.3 gets it wrong - bug #128587
DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.4
	x86? ( >=dev-lang/nasm-0.98 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-execstacks.patch"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README sample_gngeorc
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "A licensed NeoGeo BIOS copy is required to run the emulator."
	echo
}
