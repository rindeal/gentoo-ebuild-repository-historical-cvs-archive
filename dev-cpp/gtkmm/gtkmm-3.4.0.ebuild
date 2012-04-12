# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkmm/gtkmm-3.4.0.ebuild,v 1.1 2012/04/12 04:16:12 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2

DESCRIPTION="C++ interface for GTK+2"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="3.0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="aqua doc examples test wayland X"
REQUIRED_USE="|| ( aqua wayland X )"

RDEPEND="
	>=dev-cpp/glibmm-2.32.0:2
	>=x11-libs/gtk+-3.4.0:3[aqua?,wayland?,X?]
	>=x11-libs/gdk-pixbuf-2.22.1:2
	>=dev-cpp/atkmm-2.22.2
	>=dev-cpp/cairomm-1.9.2.2
	>=dev-cpp/pangomm-2.27.1:1.4
	dev-libs/libsigc++:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? (
		media-gfx/graphviz
		dev-libs/libxslt
		app-doc/doxygen )

	dev-cpp/mm-common"
# eautoreconf needs mm-common

pkg_setup() {
	DOCS="AUTHORS ChangeLog PORTING NEWS README"
	targets=
	use X && targets="x11"
	use aqua && targets="${targets},quartz"
	use wayland && targets="${targets},wayland"
	G2CONF="${G2CONF}
		--enable-api-atkmm
		--with-gdk-targets=${targets/#,/}
		$(use_enable doc documentation)"
}

src_prepare() {
	if ! use test; then
		# don't waste time building tests
		sed 's/^\(SUBDIRS =.*\)tests\(.*\)$/\1\2/' -i Makefile.am Makefile.in \
			|| die "sed 1 failed"
	fi

	if ! use examples; then
		# don't waste time building tests
		sed 's/^\(SUBDIRS =.*\)demos\(.*\)$/\1\2/' -i Makefile.am Makefile.in \
			|| die "sed 2 failed"
	fi

	# https://bugzilla.gnome.org/show_bug.cgi?id=673963
	epatch "${FILESDIR}/${PN}-3.4.0-automagic-gdk-targets.patch"

	eautoreconf
	gnome2_src_prepare
}
