# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/wmbatppc/wmbatppc-1.0-r1.ebuild,v 1.1 2004/03/16 04:45:54 warpzero Exp $

S=${WORKDIR}/wmbatppc
DESCRIPTION="wmbatppc is a small battery-monitoring dockapp. It works on G3/G4 Powerbooks and iBooks."
SRC_URI="http://titelou.free.fr/wmbatppc/${P}.tar.gz"
HOMEPAGE="http://titelou.free.fr/wmbatppc/"

DEPEND="virtual/x11
	app-laptop/pmud"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="ppc -amd64"

src_compile() {
	make || die
}

src_install () {
	dodir /usr/bin/
	dobin wmbatppc
	doman wmbatppc.1
}
