# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xine-vcdx/xine-vcdx-1_rc0.ebuild,v 1.2 2003/10/21 15:29:48 mholzer Exp $

IUSE=""

DESCRIPTION="Navigation-Capable (S)VCD Plugin for Xine movie player."
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="mirror://sourceforge/xine/${PN}-${PV/_/-}.tar.gz"
LICENSE="GPL-2"
RESTRICT="nomirror"

DEPEND=">=media-libs/xine-lib-1_rc0
	>=dev-libs/libcdio-0.62
	>=media-video/vcdimager-0.7.17"

SLOT="0"
KEYWORDS="~x86"

S=${WORKDIR}/${PN}-${PV/_/-}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		docsdir=/usr/share/doc/${PF} \
		install || die

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO
}
