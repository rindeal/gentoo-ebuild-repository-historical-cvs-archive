# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqhbci-ddvcard/aqhbci-ddvcard-0.9.5_beta.ebuild,v 1.1 2005/01/14 10:50:04 hanno Exp $

DESCRIPTION="DDV-Card plugin for aqhbci"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqhbci/${P/_/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"
IUSE="debug"
DEPEND=">=net-libs/aqhbci-0.9.6_beta
	sys-libs/chipcard-client"
S=${WORKDIR}/${P/_/}

src_compile() {
	econf `use_enable debug` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog
}
