# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-desktop/gnome-desktop-2.2.1-r1.ebuild,v 1.1 2003/04/02 13:48:24 spider Exp $

inherit gnome2 eutils

S=${WORKDIR}/${P}
DESCRIPTION="Libraries for the gnome desktop that is not part of the UI"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~sparc"
LICENSE="GPL-2 FDL-1.1 LGPL-2"

RDEPEND=">=x11-libs/gtk+-2.1.2
	>=gnome-base/libgnomeui-2.1
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/gconf-1.2
	>=x11-libs/startup-notification-0.5
	!gnome-base/gnome-core"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.22
	>=dev-util/pkgconfig-0.12.0
	>=sys-apps/sed-4"

DOCS="AUTHORS ChangeLog COPYING* README INSTALL NEWS HACKING"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/00_all_gentoo-vendor.patch
	# Fix bug 16853 by building gnome-about with IEEE to prevent
	# floating point exceptions on alpha
	use alpha || return
	cd ${S}/gnome-about
	sed -i '/^CFLAGS/s/$/ -mieee/' Makefile.in
}
