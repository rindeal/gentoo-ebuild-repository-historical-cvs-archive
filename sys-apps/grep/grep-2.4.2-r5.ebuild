# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.4.2-r5.ebuild,v 1.1 2001/12/17 21:32:00 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU regular expression matcher"
SRC_URI="ftp://prep.ai.mit.edu/gnu/grep/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/grep/grep.html"
DEPEND="virtual/glibc nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"

src_compile() {
	local myconf
	[ -z "`use nls`" ] && myconf="--disable-nls"
	./configure --prefix=/usr --bindir=/bin --mandir=/usr/share/man \
		--infodir=/usr/share/info --host=${CHOST} ${myconf} || die
	emake || die
}

src_install() {
	make prefix=${D}/usr bindir=${D}/bin mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info install || die
	if [ -z "`use build`" ]
	then
		dodoc AUTHORS COPYING ChangeLog NEWS README THANKS TODO
	else
		rm -rf ${D}/usr/share
	fi
}



