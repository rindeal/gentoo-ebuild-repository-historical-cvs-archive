# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-1.9.17.ebuild,v 1.1 2002/06/05 02:20:19 stroke Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Gnome Virtual Filesystem"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND="=dev-libs/glib-2.0*
	>=gnome-base/gconf-1.1.11
	>=gnome-base/ORBit2-2.3.108
	>=gnome-base/gnome-mime-data-1.0.7
	>=gnome-base/libbonobo-1.115.0
	>=gnome-base/bonobo-activation-0.9.7
	>=sys-devel/gettext-0.10.40
	>=dev-libs/openssl-0.9.5"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.17
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9 )"

LIBTOOL_FIX="1"

DOCS="AUTHORS COPYING* ChangeLog HACKING INSTALL NEWS README TODO"
SCHEMAS="system_http_proxy.schemas"

src_compile() {
	gnome2_src_compile DESTDIR=${D}
}

