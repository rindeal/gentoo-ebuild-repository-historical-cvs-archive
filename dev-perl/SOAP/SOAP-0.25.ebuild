# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SOAP/SOAP-0.25.ebuild,v 1.1 2000/08/28 02:59:41 achim Exp $

P=SOAP-0.25
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Perl Module for SOAP"
SRC_URI="http://cpan.valueclick.com/modules/by-module/SOAP/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/SOAP/${P}.readme"


src_compile() {

    cd ${S}
    perl Makefile.PL $PERLINSTALL
    make
#    make test

}

src_install () {

    cd ${S}
    make install
    prepman
    dodoc Changes README MANIFEST
}




