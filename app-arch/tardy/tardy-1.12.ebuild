# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tardy/tardy-1.12.ebuild,v 1.9 2008/06/22 18:24:41 vanquirius Exp $

inherit eutils

DESCRIPTION="A tar post-processor"
HOMEPAGE="http://tardy.sourceforge.net/"
SRC_URI="mirror://sourceforge/tardy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '/^CFLAGS/d' Makefile.in
	epatch "${FILESDIR}"/${P}-sort.patch
	epatch "${FILESDIR}"/${PN}-1.12-gcc43.patch
}

src_test() {
	make sure || die "test failed"
}

src_install() {
	make RPM_BUILD_ROOT="${D}" install || die "make install failed"
	dodoc README
}
