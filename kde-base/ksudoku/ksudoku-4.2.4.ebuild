# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksudoku/ksudoku-4.2.4.ebuild,v 1.1 2009/06/04 13:22:13 alexxy Exp $

EAPI="2"

KMNAME="kdegames"
OPENGL_REQUIRED="always"
inherit kde4-meta

DESCRIPTION="KDE Sudoku"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

RDEPEND="
	!kdeprefix? ( !games-puzzle/ksudoku )
"
