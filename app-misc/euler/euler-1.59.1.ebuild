# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/euler/euler-1.59.1.ebuild,v 1.1 2001/10/07 19:35:20 karltk Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Mathematical programming environment"

SRC_URI="http://prdownloads.sourceforge.net/euler/euler-1.59.1.tar.gz"

HOMEPAGE="http://euler.sf.net"

DEPEND="virtual/glibc
        virtual/x11
        >=x11-libs/gtk+-1.2"

src_unpack() {
	unpack ${P}.tar.gz
	mv euler-1.59 ${P}
	
	cd ${S}/source
	mv main.c main.c.orig
	cat main.c.orig | \
	sed -e "s:share/euler/docs/index.html:share/doc/${P}/html/index.html:" \
	> main.c
}

src_compile() {

	cd ${S}/source
	emake INSTALL_DIR=/usr || die
}

src_install () {

	cd ${S}/source
	dodir usr usr/share usr/bin
	make INSTALL_DIR=${D}/usr install || die
	
	cd ${S}
	dodir usr/share/doc/${P}/html
	mv ${D}/usr/share/euler/docs/* ${D}/usr/share/doc/${PF}/html
	rm -rf ${D}/usr/share/euler/docs
	dodoc ChangeLog README TODO
}

