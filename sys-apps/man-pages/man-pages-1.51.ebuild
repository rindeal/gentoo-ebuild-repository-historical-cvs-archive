# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man-pages/man-pages-1.51.ebuild,v 1.8 2002/12/09 04:37:26 manson Exp $

MY_PN=${PN/-/}
S=${WORKDIR}/${P}
DESCRIPTION="A somewhat comprehensive collection of Linux man pages"
SRC_URI="ftp://ftp.kernel.org/pub/linux/docs/${MY_PN}/${P}.tar.bz2"
HOMEPAGE="http://www.win.tue.nl/~aeb/linux/man/"
KEYWORDS="x86 ppc sparc "
# Modern netman versions are part of the standard man-pages for Linux
#	 ftp://ftp.suse.com/pub/people/ak/netman/netman-20000610.tgz"

RDEPEND="sys-apps/man"
LICENSE="GPL-2"
SLOT="0"

src_unpack() {

	unpack ${P}.tar.bz2
    
	cd ${S}
	tar xzf ${FILESDIR}/man2.tar.gz
}

src_install() {

#	for x in 1 2 3 4 5 6 7 8
#	do
#		doman man$x/*.[1-9]
#	done
	einstall MANDIR=${D}/usr/share/man || die
	dodoc man-pages-*.Announce README
}
