# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/gupsc/gupsc-0.3.0-r1.ebuild,v 1.1 2000/11/25 15:21:44 achim Exp $

P=gupsc-0.3.0
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="A Gnome client for the Network UPS Tools (nut)"
SRC_URI="http://www.stud.ifi.uio.no/~hennikul/gupsc/download/"${A}
HOMEPAGE="http://www.stud.ifi.uio.no/~hennikul/gupsc/"

DEPEND=">=gnome-base/gnome-libs-1.2.4"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome 
  try make
}

src_install() {                               
  cd ${S}
  try make DESTDIR=${D} install
  dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}



