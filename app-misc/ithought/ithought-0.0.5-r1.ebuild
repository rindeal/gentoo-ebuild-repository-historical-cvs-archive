# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Craig Joly <joly@ee.ualberta.ca>
# $Header: /var/cvsroot/gentoo-x86/app-misc/ithought/ithought-0.0.5-r1.ebuild,v 1.2 2001/10/07 11:11:07 azarah Exp $

#emerge doesn't yet support things like a5

P=ithought-a5
S=${WORKDIR}/${P}
DESCRIPTION="An internet-aware personal thought manager"
SRC_URI="http://download.sourceforge.net/ithought/ithought-a5.tar.gz"
HOMEPAGE="http://ithought.sourceforge.net"

DEPEND=">=x11-libs/gtk+-1.2.10-r4
	dev-libs/libxml2"

src_compile() {

    try ./configure --host=${CHOST}
    try emake

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}


