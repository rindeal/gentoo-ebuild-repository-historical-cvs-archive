# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gqview/gqview-1.2.1.ebuild,v 1.5 2003/03/02 18:31:46 avenj Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="A GTK-based image browser"
SRC_URI="mirror://sourceforge/gqview/${P}.tar.gz"
HOMEPAGE="http://gqview.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="media-libs/libpng
	>=media-libs/gdk-pixbuf-0.20*
	=x11-libs/gtk+-1.2*"
	
RDEPEND="nls? ( sys-devel/gettext )"


src_compile() {
	local myconf
	
	use nls || myconf="--disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall GNOME_DATADIR=${D}/usr/share || die
	
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
