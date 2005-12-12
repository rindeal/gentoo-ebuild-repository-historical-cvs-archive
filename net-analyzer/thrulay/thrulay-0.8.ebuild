# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/thrulay/thrulay-0.8.ebuild,v 1.1 2005/12/12 08:03:47 robbat2 Exp $

inherit toolchain-funcs

DESCRIPTION="Measure the capacity of a network by sending a bulk TCP stream over it."
HOMEPAGE="http://www.internet2.edu/~shalunov/thrulay/"
SRC_URI="${HOMEPAGE}${P}.tar.gz
		mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

src_install() {
	dobin src/thrulay || die "dobin failed"
	dosbin src/thrulayd || die "dosbin failed"
	dodoc LICENSE README TODO doc/thrulay-protocol.txt || die "dodoc failed"
	doman doc/thrulay*.[1-8] || die "doman failed"
	newinitd "${FILESDIR}"/thrulayd-init.d thrulayd || die "newinitd failed"
	newconfd "${FILESDIR}"/thrulayd-conf.d thrulayd || die "newconfd failed"
}
