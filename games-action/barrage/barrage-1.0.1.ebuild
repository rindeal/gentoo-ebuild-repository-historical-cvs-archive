# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/barrage/barrage-1.0.1.ebuild,v 1.8 2005/02/15 00:03:35 mr_bones_ Exp $

inherit games

DESCRIPTION="A violent point-and-click shooting game"
HOMEPAGE="http://lgames.sourceforge.net"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE=""

DEPEND="virtual/x11
	>=media-libs/libsdl-1.2
	>=media-libs/sdl-mixer-1.2.4"

src_compile() {
	egamesconf --datadir=${GAMES_DATADIR_BASE} || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog README
	prepgamesdirs
}
