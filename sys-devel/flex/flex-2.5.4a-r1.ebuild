# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/flex/flex-2.5.4a-r1.ebuild,v 1.6 2001/01/31 20:49:07 achim Exp $

P=flex-2.5.4a      
A=${P}.tar.gz
S=${WORKDIR}/flex-2.5.4
DESCRIPTION="GNU lexical analyser generator"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/non-gnu/flex/${A}
	 ftp://prep.ai.mit.edu/non-gnu/flex/${A}"
HOMEPAGE="http://www.gnu.org/software/flex/flex.html"

DEPEND="virtual/glibc
        sys-devel/bison"

RDEPEND="virtual/glibc"

src_compile() {                           
    try ./configure --prefix=/usr --host=${CHOST}
    try make ${MAKEOPTS}
}

src_install() {    
    try make prefix=${D}/usr install                           
    dodoc COPYING NEWS README
}


