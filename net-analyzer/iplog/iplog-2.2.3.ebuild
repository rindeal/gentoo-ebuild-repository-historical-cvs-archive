# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iplog/iplog-2.2.3.ebuild,v 1.12 2003/02/13 13:41:41 vapier Exp $


S=${WORKDIR}/${P}
DESCRIPTION="iplog is a TCP/IP traffic logger"
SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"
HOMEPAGE="http://ojnk.sourceforge.net/"

DEPEND="net-libs/libpcap"

SLOT="0"
LICENSE="GPL-2 | FDL-1.1"
KEYWORDS="x86 ppc sparc "

src_compile() {

	econf || die
	make CFLAGS="${CFLAGS} -D_REENTRANT" all || die

}

src_install() {

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die

	dodoc AUTHORS COPYING.* NEWS README TODO example-iplog.conf
}

