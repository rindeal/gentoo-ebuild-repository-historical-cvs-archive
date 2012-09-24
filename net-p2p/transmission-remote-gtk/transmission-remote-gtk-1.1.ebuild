# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission-remote-gtk/transmission-remote-gtk-1.1.ebuild,v 1.2 2012/09/24 12:05:24 ssuominen Exp $

EAPI=4
inherit autotools eutils fdo-mime gnome2-utils

DESCRIPTION="GTK+ client for management of the Transmission BitTorrent client, over HTTP RPC"
HOMEPAGE="http://code.google.com/p/transmission-remote-gtk"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ayatana debug geoip libnotify libproxy"

RESTRICT="test"

RDEPEND=">=dev-libs/glib-2.30
	>=dev-libs/json-glib-0.12.6
	net-misc/curl
	x11-libs/gtk+:3
	ayatana? ( dev-libs/libappindicator:3 )
	geoip? ( dev-libs/geoip )
	libnotify? ( >=x11-libs/libnotify-0.7 )
	libproxy? ( net-libs/libproxy )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog README"

src_prepare() {
	epatch "${FILESDIR}"/${P}-PKG_PROG_PKG_CONFIG.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		--enable-gtk3 \
		$(use_with geoip libgeoip) \
		$(use_with libnotify) \
		$(use_with libproxy) \
		$(use_with ayatana libappindicator)
}

pkg_preinst() {	gnome2_icon_savelist; }
pkg_postinst() { fdo-mime_desktop_database_update; gnome2_icon_cache_update; }
pkg_postrm() { fdo-mime_desktop_database_update; gnome2_icon_cache_update; }
