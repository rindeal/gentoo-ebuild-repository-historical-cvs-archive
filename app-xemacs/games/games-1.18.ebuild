# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/games/games-1.18.ebuild,v 1.1 2009/02/22 13:16:33 graaff Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Tetris, Sokoban, and Snake."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages
