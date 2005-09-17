# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-2.12.0.ebuild,v 1.3 2005/09/17 12:10:25 agriffis Exp $

DESCRIPTION="Meta package for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="as-is"
SLOT="2.0"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"

IUSE="accessibility cdr dvdr hal"

S=${WORKDIR}

RDEPEND="!gnome-base/gnome-core

	>=dev-libs/glib-2.8.1
	>=x11-libs/gtk+-2.8.3
	>=dev-libs/atk-1.10.3
	>=x11-libs/pango-1.10

	>=dev-libs/libxml2-2.6.21
	>=dev-libs/libxslt-1.1.15

	>=media-libs/audiofile-0.2.6-r1
	>=media-sound/esound-0.2.36
	>=x11-libs/libxklavier-2
	>=media-libs/libart_lgpl-2.3.17

	>=dev-libs/libIDL-0.8.6
	>=gnome-base/orbit-2.12.4

	>=x11-libs/libwnck-2.12.0

	>=gnome-base/gnome-keyring-0.4.4
	>=gnome-extra/gnome-keyring-manager-2.12.0

	>=gnome-base/gnome-vfs-2.12.0

	>=gnome-base/gnome-mime-data-2.4.2

	>=gnome-base/gconf-2.12.0
	>=net-libs/libsoup-2.2.6.1

	>=gnome-base/libbonobo-2.10.1
	>=gnome-base/libbonoboui-2.10.1
	>=gnome-base/libgnome-2.12.0
	>=gnome-base/libgnomeui-2.12.0
	>=gnome-base/libgnomecanvas-2.12.0
	>=gnome-base/libglade-2.5.1

	>=gnome-extra/bug-buddy-2.12.0
	>=gnome-base/control-center-2.12.0

	>=gnome-base/eel-2.12.0
	>=gnome-base/nautilus-2.12.0

	>=media-libs/gstreamer-0.8.11
	>=media-libs/gst-plugins-0.8.11
	>=gnome-extra/gnome-media-2.12.0
	>=media-sound/sound-juicer-2.12.0
	>=media-video/totem-1.2.0

	>=media-gfx/eog-2.12.0

	>=www-client/epiphany-1.8.0
	>=app-arch/file-roller-2.12.0
	>=gnome-extra/gcalctool-5.6.31

	>=gnome-extra/gconf-editor-2.12.0
	>=gnome-base/gdm-2.8.0.4
	>=app-editors/gedit-2.12.0

	>=app-text/evince-0.4.0

	>=gnome-base/gnome-desktop-2.12.0
	>=gnome-base/gnome-session-2.12.0
	>=gnome-base/gnome-applets-2.12.0
	>=gnome-base/gnome-panel-2.12.0
	>=gnome-base/gnome-menus-2.12.0
	>=x11-themes/gnome-icon-theme-2.12.0
	>=x11-themes/gnome-themes-2.12.0

	>=x11-themes/gtk-engines-2.6.5
	>=x11-themes/gnome-backgrounds-2.12.0

	>=x11-libs/vte-0.11.15
	>=x11-terms/gnome-terminal-2.12.0

	>=x11-libs/gtksourceview-1.4.1
	>=gnome-extra/gucharmap-1.4.3
	>=gnome-base/libgnomeprint-2.12
	>=gnome-base/libgnomeprintui-2.12

	>=gnome-extra/gnome-utils-2.12.0

	>=gnome-extra/gnome-games-2.12.0
	>=gnome-base/librsvg-2.11.1

	>=gnome-extra/gnome-system-monitor-2.12.0
	>=gnome-base/libgtop-2.12.0

	>=x11-wm/metacity-2.12.0

	>=x11-libs/startup-notification-0.8

	>=gnome-extra/gnome2-user-docs-2.8.1
	>=gnome-extra/yelp-2.12.0
	>=gnome-extra/zenity-2.12.0

	>=net-analyzer/gnome-netstatus-2.12.0
	>=net-analyzer/gnome-nettool-1.4.0

	cdr? ( >=gnome-extra/nautilus-cd-burner-2.12.0 )
	dvdr? ( >=gnome-extra/nautilus-cd-burner-2.12.0 )

	hal? ( >=gnome-base/gnome-volume-manager-1.5.1 )

	>=gnome-extra/libgtkhtml-3.8.0
	>=mail-client/evolution-2.4.0
	>=gnome-extra/evolution-data-server-1.4.0
	>=gnome-extra/evolution-webcal-2.4.0.1

	>=net-misc/vino-2.12.0

	>=app-admin/gnome-system-tools-1.4.0
	>=app-admin/system-tools-backends-1.4.0

	accessibility? (
		>=gnome-extra/libgail-gnome-1.1.1
		>=gnome-base/gail-1.8.5
		>=gnome-extra/at-spi-1.6.6
		>=app-accessibility/dasher-3.2.18
		>=app-accessibility/gnome-mag-0.12.1
		>=app-accessibility/gnome-speech-0.3.7
		>=app-accessibility/gok-1.0.5
		>=app-accessibility/gnopernicus-0.11.6 )"

# Development tools
#   scrollkeeper
#   pkgconfig
#   intltool
#   gtk-doc
#   gnome-doc-utils


pkg_postinst() {

	einfo "Note that to change windowmanager to metacity do: "
	einfo " export WINDOW_MANAGER=\"/usr/bin/metacity\""
	einfo "of course this works for all other window managers as well"
	einfo
	einfo "To take full advantage of GNOME's functionality, please start"
	einfo "the File Alteration Monitoring service (famd) before using"
	einfo "GNOME, unless you have a specific reason for not doing so."
	einfo
	einfo "To start famd now use:"
	einfo "'/etc/init.d/famd start'"
	einfo
	einfo "And please ensure you add it to the default runlevel using:"
	einfo "'rc-update add famd default'"
	einfo
	einfo "Add yourself to the plugdev group if you want"
	einfo "automounting to work."
	einfo
}
