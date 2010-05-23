# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/nestopia/nestopia-1.40.ebuild,v 1.3 2010/05/23 17:49:03 pacho Exp $

EAPI=2
inherit eutils games

MY_PV="${PV//./}"
LNX_P="nst${MY_PV}_lnx_release_h"
DESCRIPTION="NEStopia is a portable Nintendo Entertainment System emulator written in C++"
HOMEPAGE="http://rbelmont.mameworld.info/?page_id=200"
SRC_URI="mirror://sourceforge/${PN}/Nestopia${MY_PV}src.zip
	http://rbelmont.mameworld.info/${LNX_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.4:2
	media-libs/alsa-lib
	>=media-libs/libsdl-1.2.12[audio,joystick,video]
	sys-libs/zlib
	virtual/opengl
	virtual/glu"

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	sed \
	    -e "s:%GAMES_DATADIR%:${GAMES_DATADIR}:g" \
	    "${FILESDIR}"/${PN} \
	    > ${PN} \
	    || die "sed failed"
}

src_install() {
	newgamesbin nst ${PN}.bin || die "dobin failed"
	dogamesbin ${PN} || die "dobin failed"

	insinto "${GAMES_DATADIR}/${PN}"
	doins NstDatabase.xml nstcontrols || die "doins failed"

	make_desktop_entry "${PN}" "Nestopia"

	dodoc README.Linux changelog.txt
	dohtml -r readme.html doc/*.html doc/details

	prepgamesdirs
}
