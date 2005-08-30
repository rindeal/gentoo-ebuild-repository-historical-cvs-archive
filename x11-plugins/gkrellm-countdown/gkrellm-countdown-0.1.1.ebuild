# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-countdown/gkrellm-countdown-0.1.1.ebuild,v 1.5 2005/08/30 07:15:36 s4t4n Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A simple countdown clock for GKrellM2"
SRC_URI="http://www.cise.ufl.edu/~jcjones/src/${P}.tar.gz"
HOMEPAGE="http://www.cise.ufl.edu/~jcjones/src/"

DEPEND=">=app-admin/gkrellm-2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
IUSE=""

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm2/plugins
	doexe gkrellm-countdown.so
	dodoc README
	dodoc ChangeLog
}
