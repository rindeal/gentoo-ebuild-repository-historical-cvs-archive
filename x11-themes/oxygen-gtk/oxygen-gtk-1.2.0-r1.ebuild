# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/oxygen-gtk/oxygen-gtk-1.2.0-r1.ebuild,v 1.3 2012/02/16 19:07:33 scarabeus Exp $

EAPI=4

MY_PN=${PN}2
MY_P=${MY_PN}-${PV}

inherit cmake-utils

DESCRIPTION="Official GTK+:2 port of KDE's Oxygen widget style"
HOMEPAGE="https://projects.kde.org/projects/playground/artwork/oxygen-gtk"
SRC_URI="mirror://kde/stable/${MY_PN}/${PV}/src/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="amd64 x86"
SLOT="2"
IUSE="debug doc"

RDEPEND="
	!x11-themes/oxygen-gtk:0
	dev-libs/dbus-glib
	dev-libs/glib
	x11-libs/cairo
	>=x11-libs/gtk+-2.24.2:2
	x11-libs/libX11
	x11-libs/pango
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )
"

DOCS=(AUTHORS README)

S="${WORKDIR}/${MY_P}"

src_install() {
	if use doc; then
		{ cd "${S}" && doxygen Doxyfile; } || die "Generating documentation failed"
		HTML_DOCS=( "${S}/doc/html/" )
	fi

	cmake-utils_src_install

	cat <<-EOF > 99oxygen-gtk2
CONFIG_PROTECT="${EPREFIX}/usr/share/themes/oxygen-gtk/gtk-2.0"
EOF
	doenvd 99oxygen-gtk2
}
