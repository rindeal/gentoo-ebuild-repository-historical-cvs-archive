# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spim/spim-6.5.ebuild,v 1.10 2004/06/24 22:34:40 agriffis Exp $

inherit eutils

DESCRIPTION="MIPS Simulator"
HOMEPAGE="http://www.cs.wisc.edu/~larus/spim.html"
# No version upstream
#SRC_URI="http://www.cs.wisc.edu/~larus/SPIM/spim.tar.gz"
SRC_URI="mirror://gentoo//${P}.tar.gz"

KEYWORDS="x86 amd64 ~ppc"
LICENSE="as-is"
SLOT="0"
IUSE="X"

RDEPEND="X? ( virtual/x11 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	# fix bad code generation (bug #47141)
	epatch "${FILESDIR}/${PV}-parser.patch"
}

src_compile() {
	./Configure || die "Configure script failed"

	sed -i \
		-e 's/@make/@$(MAKE)/' \
		-e "s:\(BIN_DIR = \).*$:\1/usr/bin:" \
	    -e "s:\(MAN_DIR = \).*$:\1/usr/share/bin:" \
	    -e "s:\(TRAP_DIR = \).*$:\1/usr/sbin:" Makefile \
			|| die "sed Makefile failed"

	emake spim || die "make spim failed"
	if use X ; then
		emake xspim || die "emake xspim failed"
	fi
}

src_install() {
	dobin spim || die "dobin failed"
	newman spim.man spim.1
	if use X ; then
		dobin xspim || die "dobin failed"
		newman xspim.man xspim.1
	fi
	dosbin trap.handler || die "dosbin failed"
	dodoc BLURB README VERSION ChangeLog Documentation/*
}
