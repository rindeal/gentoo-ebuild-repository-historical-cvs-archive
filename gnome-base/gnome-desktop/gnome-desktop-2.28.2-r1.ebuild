# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-desktop/gnome-desktop-2.28.2-r1.ebuild,v 1.7 2010/11/02 02:10:17 ford_prefect Exp $

EAPI="2"

inherit gnome2 eutils

DESCRIPTION="Libraries for the gnome desktop that are not part of the UI"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm ia64 ~ppc ~ppc64 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.14.0
	>=dev-libs/glib-2.19.1
	>=x11-libs/libXrandr-1.2
	>=gnome-base/gconf-2
	>=x11-libs/startup-notification-0.5"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	>=dev-util/pkgconfig-0.9
	>=app-text/gnome-doc-utils-0.3.2
	doc? ( >=dev-util/gtk-doc-1.4 )
	~app-text/docbook-xml-dtd-4.1.2
	x11-proto/xproto
	>=x11-proto/randrproto-1.2"
PDEPEND=">=dev-python/pygtk-2.8
	>=dev-python/pygobject-2.14"

# Includes X11/Xatom.h in libgnome-desktop/gnome-bg.c which comes from xproto
# Includes X11/extensions/Xrandr.h that includes randr.h from randrproto (and
# eventually libXrandr shouldn't RDEPEND on randrproto)

DOCS="AUTHORS ChangeLog HACKING NEWS README"

pkg_setup() {
	G2CONF="${G2CONF}
		--with-gnome-distributor=Gentoo
		--disable-scrollkeeper
		--disable-static"
}

src_prepare() {
	gnome2_src_prepare

	# Fix slideshow regression, see upstream #601753
	epatch "${FILESDIR}/${PN}-2.28.2-slideshow-fix.patch"

	# Fix intltoolize broken file, see upstream #577133
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in \
		|| die "sed failed"
}
