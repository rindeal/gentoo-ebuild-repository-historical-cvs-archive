# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pipes/pipes-1.16.1.ebuild,v 1.1 2011/04/22 16:07:20 jer Exp $

EAPI="3"

inherit toolchain-funcs

DESCRIPTION="Very versatile TCP pipes"
HOMEPAGE="http://bisqwit.iki.fi/source/pipes.html"
SRC_URI="http://bisqwit.iki.fi/src/arch/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~s390 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_prepare() {
	sed -i Makefile -e "s:-O2:${CFLAGS}:" || die
	touch .depend
}

src_compile() {
	emake CC=$(tc-getCC) LDFLAGS="${CFLAGS} ${LDFLAGS}" || die "emake failed"
}

src_install() {
	dobin plis || die "dobin failed"
	dohard /usr/bin/plis /usr/bin/pcon || die "dohard failed"
	dodoc Examples ChangeLog
	dohtml README.html
}
