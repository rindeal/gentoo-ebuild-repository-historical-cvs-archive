# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/beast/beast-0.5.1.ebuild,v 1.2 2003/06/04 18:12:30 liquidx Exp $

DESCRIPTION="BEAST - the Bedevilled Sound Engine"
HOMEPAGE="http://beast.gtk.org"
SRC_URI="ftp://beast.gtk.org/pub/beast/v${PV%.[0-9]}/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.0
	>=x11-libs/gtk+-2.0.0
	>=media-libs/libvorbis-1.0
	>=media-libs/libogg-1.0
	>=media-sound/mad-0.14.2
	>=sys-libs/zlib-1.1.3
	>=dev-util/guile-1.4
	>=media-libs/libart_lgpl-2.3.8
	>=gnome-base/libgnomecanvas-2"
	
DEPEND="dev-util/pkgconfig
	dev-lang/perl
	${RDEPEND}"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING COPYING.LIB INSTALL README docs/*[faq.txt] 
}
