# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-2.4.1.ebuild,v 1.7 2004/02/10 06:29:34 darkspecter Exp $

inherit gnome2

IUSE="spell"
DESCRIPTION="A text editor for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha sparc hppa ~amd64 ia64"

RDEPEND=">=gnome-base/libglade-2
	>=dev-libs/popt-1.5
	>=gnome-base/eel-2.4
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2.4
	>=gnome-base/libbonobo-2.3
	>=gnome-base/libgnomeprintui-2.4
	>=x11-libs/gtksourceview-0.7
	spell? ( virtual/aspell-dict )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.25"

DOCS="AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README THANKS TODO"

