# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlite/sqlite-2.1.3-r1.ebuild,v 1.2 2002/01/13 23:50:19 azarah Exp $

S=${WORKDIR}/sqlite
DESCRIPTION="SQLite: An SQL Database Engine in a C Library."
SRC_URI="http://www.hwaci.com/sw/sqlite/${P}.tar.gz"
HOMEPAGE="http://www.hwaci.com/sw/sqlite/"

DEPEND="virtual/glibc
	dev-lang/tcl-tk"

src_compile() {

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc || die
		
	emake || die
	make doc || die
}

src_install () {
	
	dodir /usr/{bin,include,lib}
	
	make prefix=${D}/usr \
	     mandir=${D}/usr/share/man \
	     infodir=${D}/usr/share/info \
	     sysconfdir=${D}/etc \
	     install || die

	dobin lemon

	dodoc README VERSION 
	docinto html
	dodoc doc/*.html doc/*.txt doc/*.png
}
