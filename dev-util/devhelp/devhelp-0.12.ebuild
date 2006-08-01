# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devhelp/devhelp-0.12.ebuild,v 1.1 2006/08/01 09:09:34 leonardop Exp $

inherit gnome2

DESCRIPTION="An API documentation browser for GNOME 2"
HOMEPAGE="http://developer.imendio.com/wiki/Devhelp"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="firefox zlib"

RDEPEND=">=gnome-base/gconf-2.6
	>=x11-libs/gtk+-2.8
	>=dev-libs/glib-2.8
	>=gnome-base/libglade-2.4
	>=x11-libs/libwnck-2.10
	sparc? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	!sparc? ( !firefox?	( >=www-client/seamonkey-1 ) )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.28
	sys-devel/gettext
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog NEWS README"


pkg_setup() {
	G2CONF="$(use_with zlib)"

	if use firefox || use sparc; then
		G2CONF="${G2CONF} --with-gecko=firefox"
	else
		G2CONF="${G2CONF} --with-gecko=seamonkey"
	fi
}
