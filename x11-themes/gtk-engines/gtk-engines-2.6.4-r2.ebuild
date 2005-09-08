# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines/gtk-engines-2.6.4-r2.ebuild,v 1.5 2005/09/08 15:43:49 agriffis Exp $

inherit gnome2

DESCRIPTION="GTK+2 standard engines and themes"
HOMEPAGE="http://www.gtk.org/"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ia64 ~mips ~ppc ppc64 sparc x86"
LICENSE="GPL-2 LGPL-2.1"
SLOT="2"
IUSE="accessibility static"

RDEPEND=">=x11-libs/gtk+-2.6
	!<=x11-themes/gnome-themes-2.8.2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"


pkg_setup() {
	G2CONF="${G2CONF} $(use_enable static)"
	use accessibility || G2CONF="${G2CONF} --disable-hc"
}
