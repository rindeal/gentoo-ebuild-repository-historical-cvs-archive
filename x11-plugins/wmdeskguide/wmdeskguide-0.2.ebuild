# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdeskguide/wmdeskguide-0.2.ebuild,v 1.5 2003/10/16 16:10:23 drobbins Exp $

MY_P=${P/deskg/DeskG}
S=${WORKDIR}/${MY_P}

DESCRIPTION="WMaker DockApp: GNOME 1.4 DeskGuide port for the Window Maker environment."
SRC_URI="http://charybda.icm.edu.pl/~jarwyp/download/${MY_P}.tar.gz"
HOMEPAGE="http://charybda.icm.edu.pl/~jarwyp/"

DEPEND="virtual/x11
	>=gnome-base/gnome-libs-1.4
	>=media-libs/gdk-pixbuf-0.22.0
	=x11-libs/gtk+-1.2*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 amd64"

src_compile() {
	make
}

src_install () {
	dobin wmDeskGuide
}
