# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gramps/gramps-1.0.1.ebuild,v 1.1 2004/04/02 01:56:19 pylon Exp $

inherit gnome2

IUSE=""
DESCRIPTION="Genealogical Research and Analysis Management Programming System"
SRC_URI="mirror://sourceforge/gramps/${P}.tar.gz"
HOMEPAGE="http://gramps.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

RDEPEND=">=dev-lang/python-2.2
	>=dev-python/pygtk-1.99.14
	>=dev-python/gnome-python-1.99.14
	>=gnome-base/gnome-vfs-2.0
	>=dev-python/pyxml-0.7.1
	>=dev-python/Imaging-1.1.3
	>=dev-python/reportlab-1.11"

DEPEND="${RDEPEND}
	dev-lang/swig
	dev-util/pkgconfig
	app-text/scrollkeeper"

DOCS="COPYING NEWS README TODO"
MAKEOPTS="${MAKEOPTS} -j1"
pkg_setup() {
	if ! python -c "import gtk.glade" 2>&1 > /dev/null ; then
		eerror "You need to install pygtk with libglade support. Try:"
		eerror "USE='gnome' emerge pygtk gramps"
		die "libglade support missing from pygtk"
	fi
}

src_install() {
	gnome2_src_install

	# fix menu entry location
	dodir /usr/share/applications
	mv ${D}/usr/share/gnome/apps/Applications/gramps.desktop \
		${D}/usr/share/applications
	rm -rf ${D}/usr/share/gnome
}
