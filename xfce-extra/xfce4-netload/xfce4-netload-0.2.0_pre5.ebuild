# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-netload/xfce4-netload-0.2.0_pre5.ebuild,v 1.1 2003/09/03 23:56:16 bcowan Exp $ 

IUSE=""
MY_P="${PN}-plugin-${PV/_/}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Xfce4 panel network load monitor plugin"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://download.berlios.de/xfce-goodies/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND=">=x11-libs/gtk+-2.0.6
	dev-util/pkgconfig
	dev-libs/libxml2
	xfce-base/xfce4-base"

src_install() {
	make DESTDIR=${D} install || die
                                                                                                                                           
        dodoc AUTHORS INSTALL COPYING README 
}
