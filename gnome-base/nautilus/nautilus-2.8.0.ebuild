# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-2.8.0.ebuild,v 1.9 2004/12/11 10:28:49 kloeri Exp $

inherit gnome2 eutils

DESCRIPTION="A filemanager for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/projects/nautilus/"

LICENSE="GPL-2 LGPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc ~hppa ~amd64 ~ia64 ~mips ~arm"
IUSE="oggvorbis cups gstreamer mad flac"

RDEPEND=">=dev-libs/glib-2.3
	>=x11-libs/pango-1.2
	>=x11-libs/gtk+-2.3
	>=dev-libs/libxml2-2.4.7
	=gnome-base/eel-${PV}*
	>=gnome-base/gnome-vfs-2.5.1
	>=media-sound/esound-0.2.27
	>=gnome-base/gconf-2
	>=gnome-base/libgnome-2.6
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/gnome-desktop-2.2
	>=media-libs/libart_lgpl-2.3.10
	>=gnome-base/libbonobo-2.2
	>=gnome-base/libbonoboui-2.2
	>=gnome-base/librsvg-2.0.1
	>=gnome-base/orbit-2.4
	>=x11-libs/startup-notification-0.5
	dev-libs/popt
	virtual/fam
	sys-apps/eject
	cups? ( net-print/libgnomecups
		net-print/gnome-cups-manager )
	!gstreamer? ( oggvorbis? ( media-sound/vorbis-tools ) )
	gstreamer? (
		>=media-libs/gstreamer-0.8
		>=media-libs/gst-plugins-0.8
		mad? ( >=media-plugins/gst-plugins-mad-0.8 )
		oggvorbis? (
			>=media-plugins/gst-plugins-ogg-0.8
			>=media-plugins/gst-plugins-vorbis-0.8
		)
		flac? (	>=media-plugins/gst-plugins-flac-0.8 )
	)"

# FIXME : what to do with exif/jpeg config stuff ?

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.29
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/pkgconfig-0.12.0"

PDEPEND=">=x11-themes/gnome-icon-theme-1.1.91
	x11-themes/gnome-themes"

DOCS="AUTHORS ChangeLo* HACKING INSTALL MAINTAINERS NEWS README THANKS TODO"

G2CONF="${G2CONF} $(use_enable gstreamer)"

src_unpack() {

	unpack ${A}

	cd ${S}
	# use gstreamer for audio preview (patch by <foser@gentoo.org>)
	use gstreamer && epatch ${FILESDIR}/${PN}-2.6-icon_view_gst_audio_preview.patch
	# add libgnomeprint support
	use cups && epatch ${FILESDIR}/${PN}-2-x-printers.patch

	# patch to support libexif versions 0.5 and 0.6
	epatch ${FILESDIR}/${PN}-2-libexif.patch

	# and we always need to regenerate now, because we
	# always apply the libexif patch <obz@gentoo.org>
	WANT_AUTOCONF=2.5 autoheader || die
	WANT_AUTOCONF=2.5 autoconf || die
	WANT_AUTOMAKE=1.4 automake || die

}

pkg_postinst() {

	gnome2_pkg_postinst

	einfo "Nautilus moved to a new spatial browsing model."
	einfo "If you are unhappy with this behaviour you can revert to the"
	einfo "old browerslike behaviour by issueing the following command :"
	einfo "gconftool-2  -s /apps/nautilus/preferences/always_use_browser -t bool TRUE"

}
