# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/at-spi/at-spi-1.4.0.ebuild,v 1.3 2004/04/28 21:33:17 gustavoz Exp $

inherit gnome2

DESCRIPTION="The Gnome Accessibility Toolkit"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

SLOT="1"
LICENSE="LGPL-2"
KEYWORDS="x86 ~ppc ~alpha ~amd64 sparc ~hppa ~ia64"
IUSE=""

RDEPEND=">=gnome-base/gail-1.3
	>=gnome-base/libbonobo-1.107
	>=dev-libs/atk-1.3.4
	>=x11-libs/gtk+-2
	dev-libs/popt
	gnome-base/ORBit2
	virtual/x11"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig
	dev-util/intltool"

MAKEOPTS="${MAKEOPTS} -j1"

DOCS="AUTHORS ChangeLog COPYING NEWS README TODO"
