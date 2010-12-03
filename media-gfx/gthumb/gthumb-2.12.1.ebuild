# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-2.12.1.ebuild,v 1.1 2010/12/03 23:36:53 pacho Exp $

EAPI="3"
GCONF_DEBUG="yes"

inherit gnome2

DESCRIPTION="Image viewer and browser for Gnome"
HOMEPAGE="http://gthumb.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="cdr exif gnome-keyring gstreamer http raw slideshow tiff test"

# TODO: beware, can link to brasero-3
RDEPEND=">=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.20:2
	>=gnome-base/gconf-2.6
	>=dev-libs/libunique-1.1.2
	media-libs/libpng:0
	virtual/jpeg:0
	cdr? ( >=app-cdr/brasero-2.28 )
	exif? ( >=media-gfx/exiv2-0.18 )
	gnome-keyring? ( >=gnome-base/gnome-keyring-2.28 )
	gstreamer? (
		>=media-libs/gstreamer-0.10
		>=media-libs/gst-plugins-base-0.10 )
	http? (
		>=net-libs/libsoup-2.26:2.4
		>=net-libs/libsoup-gnome-2.26:2.4 )
	slideshow? (
		>=media-libs/clutter-1:1.0
		>=media-libs/clutter-gtk-0.10:1.0 )
	tiff? ( media-libs/tiff )
	raw? ( >=media-libs/libopenraw-0.0.8 )
	!raw? ( media-gfx/dcraw )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/scrollkeeper
	>=dev-util/intltool-0.35
	app-text/gnome-doc-utils
	test? ( ~app-text/docbook-xml-dtd-4.1.2 )"
# eautoreconf needs:
#	gnome-base/gnome-common

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		--disable-maintainer-mode
		$(use_enable cdr libbrasero)
		$(use_enable exif exiv2)
		$(use_enable gstreamer)
		$(use_enable gnome-keyring)
		$(use_enable http libsoup)
		$(use_enable raw libopenraw)
		$(use_enable slideshow clutter)
		$(use_enable test test-suite)
		$(use_enable tiff)"
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	gnome2_src_prepare

	# Remove unwanted CFLAGS added with USE=debug
	sed 's/CFLAGS+=" -g -O0 -DDEBUG"//' -i configure.ac configure || die
}

src_install() {
	gnome2_src_install

	# gthumb does not need *.la files
	find "${ED}" -name "*.la" -delete || die "*.la files removal failed"
}
