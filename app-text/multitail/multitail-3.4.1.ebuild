# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/multitail/multitail-3.4.1.ebuild,v 1.2 2005/01/01 16:26:52 eradicator Exp $

DESCRIPTION="Tail with multiple windows."
HOMEPAGE="http://www.vanheusden.com/multitail/index.html"
SRC_URI="http://www.vanheusden.com/multitail/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~ia64 ~amd64 ~ppc ~sparc"

IUSE="debug"
DEPEND="virtual/libc
	sys-libs/ncurses"

src_compile() {
	CFLAGS="${CFLAGS} -D`uname` -DVERSION=\\\"${PV}\\\""
	use debug && CFLAGS="${CFLAGS} -g -D_DEBUG"
	make all CFLAGS="${CFLAGS}" || die "make failed"
}

src_install () {
	dobin multitail
	dodoc Changes INSTALL license.txt readme.txt multitail.conf
	dohtml manual.html
	doman multitail.1
}
