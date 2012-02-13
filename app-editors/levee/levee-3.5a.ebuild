# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/levee/levee-3.5a.ebuild,v 1.6 2012/02/13 16:30:44 darkside Exp $

EAPI=4

inherit toolchain-funcs eutils

DESCRIPTION="Really tiny vi clone, for things like rescue disks"
HOMEPAGE="http://www.pell.chi.il.us/~orc/Code/"
SRC_URI="http://www.pell.chi.il.us/~orc/Code/levee/${P}.tar.gz"

LICENSE="levee"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND="!app-text/lv
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.4o-darwin.patch
	epatch "${FILESDIR}"/${P}-QA.patch
	epatch "${FILESDIR}"/${PN}-3.5-glibc210.patch
}

src_compile() {
	export AC_CPP_PROG=$(tc-getCPP)
	export AC_PATH=${PATH}
	./configure.sh --prefix="${PREFIX}"/usr || die "configure failed"
	emake CFLAGS="${CFLAGS} -Wall -Wextra ${LDFLAGS}" CC=$(tc-getCC)
}

src_install() {
	emake PREFIX="${D}${EPREFIX}" install
}
