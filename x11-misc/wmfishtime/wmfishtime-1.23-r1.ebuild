# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmfishtime/wmfishtime-1.23-r1.ebuild,v 1.4 2002/07/08 21:31:07 aliz Exp $

# to make this work in KDE, run it with the -b option :)
DESCRIPTION="A fun clock applet for your desktop featuring swimming fish"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

S=${WORKDIR}/${P}
SRC_URI="http://www.ne.jp/asahi/linux/timecop/software/${P}.tar.gz"
DEPEND="virtual/glibc =x11-libs/gtk+-1.2*"

src_compile() {

	sed -e "s/CFLAGS = -O3/CFLAGS = ${CFLAGS}/" Makefile | cat > Makefile
	make || die
}

src_install () {

	into /usr
	dobin wmfishtime
	doman wmfishtime.1
	dodoc ALL_I_GET_IS_A_GRAY_BOX CODING INSTALL README AUTHORS COPYING
}
