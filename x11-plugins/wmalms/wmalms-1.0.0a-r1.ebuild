# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmalms/wmalms-1.0.0a-r1.ebuild,v 1.5 2003/10/16 16:10:23 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="wmalms X-windows hardware sensors applet"
HOMEPAGE="http://www.geocities.com/wmalms"
SRC_URI="http://www.geocities.com/wmalms/wmalms-1.0.0a.tar.gz"

DEPEND="virtual/x11
	sys-apps/lm-sensors"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make BINDIR=${D}/usr/bin DOCDIR=${D}/usr/share/doc/${P} install
}
