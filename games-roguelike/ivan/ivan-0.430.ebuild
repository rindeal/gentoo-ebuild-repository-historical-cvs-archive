# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/ivan/ivan-0.430.ebuild,v 1.5 2004/05/27 04:42:59 mr_bones_ Exp $

inherit games

DESCRIPTION="Rogue-like game with SDL graphics"
HOMEPAGE="http://ivan.sourceforge.net/"
SRC_URI="mirror://sourceforge/ivan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.0"

src_install() {
	egamesinstall || die
	dodoc AUTHORS ChangeLog LICENSING NEWS README
	prepgamesdirs
	fperms g+w "${GAMES_STATEDIR}/ivan/Bones"
}
