# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/pango/pango-1.0.5.ebuild,v 1.1 2002/10/13 23:02:15 foser Exp $

IUSE="doc"

inherit libtool

SLOT="1"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"

S=${WORKDIR}/${P}
DESCRIPTION="Text rendering and Layout library"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.0/${P}.tar.bz2"
HOMEPAGE="http://www.pango.org/"
LICENSE="LGPL-2.1"

RDEPEND="virtual/x11
	>=dev-libs/glib-2
	>=media-libs/freetype-2.0.1"
	
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9 )"


src_compile() {
	elibtoolize
	local myconf
	use doc && myconf="--enable-gtk-doc" || myconf="--disable-gtk-doc"
	if [ -n "$DEBUG" ]; then
		myconf="${myconf}  --enable-debug"
	fi
				
	
	econf ${myconf} --without-qt  || die
	make || die "serial make failed" 
}

src_install() {
	einstall
	rm ${D}/etc/pango/pango.modules


 	dodoc AUTHORS ChangeLog COPYING README INSTALL NEWS TODO*
}

pkg_postinst() {
	pango-querymodules >/etc/pango/pango.modules
}

