# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gputils/gputils-0.13.6-r1.ebuild,v 1.2 2010/10/10 01:32:07 hwoarang Exp $

inherit eutils

DESCRIPTION="Collection of tools including assembler, linker and librarian for PIC microcontrollers."
HOMEPAGE="http://gputils.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-code_pack.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO doc/gputils.ps
	insinto /usr/share/doc/${PF}/
	doins doc/gputils.pdf
}
