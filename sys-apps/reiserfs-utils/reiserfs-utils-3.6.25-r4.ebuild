# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/reiserfs-utils/reiserfs-utils-3.6.25-r4.ebuild,v 1.2 2001/03/10 00:22:17 drobbins Exp $

S=${WORKDIR}/${P}
S0=${WORKDIR}/reiserfsprogs-3.x.0f
DESCRIPTION="Reiserfs Utilities"
SRC_URI="ftp://ftp.namesys.com/pub/reiserfsprogs/${P}.tar.gz
	 ftp://ftp.namesys.com/pub/reiserfsprogs/reiserfsprogs-3.x.0f.tar.gz"
HOMEPAGE="http://www.namesys.com"

src_unpack() {

  unpack ${A}
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile

}

src_compile() {

    try make
    cd ${S0}
    try ./configure --host=${CHOST}
    try make

}

src_install () {

    dodir /sbin
    dodir /usr/share/man/man8
    try make SBIN=${D}sbin MANDIR=${D}usr/share/man/man8 install
    dodoc README
    cd ${S0}
    doman fsck/reiserfsck.8
    into /
    dosbin fsck/reiserfsck
    dosym /bin/true /sbin/fsck.reiserfs


}

