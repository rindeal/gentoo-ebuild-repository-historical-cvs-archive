# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/chkrootkit/chkrootkit-0.35.ebuild,v 1.3 2002/07/08 15:59:17 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="chkrootkit is a tool to locally check for signs of a rootkit.
"
SRC_URI="ftp://ftp.pangeia.com.br/pub/seg/pac/${PN}.tar.gz"
HOMEPAGE="http://www.chkrootkit.org/"
LICENSE="AMS"
KEYWORDS="x86"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {
	make sense
}

src_install () {
	dosbin check_wtmpx chklastlog chkproc chkrootkit chkwtmp ifpromisc 
	dodoc COPYRIGHT README README.chklastlog README.chkwtmp
}
