# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/star/star-1.5_alpha06-r1.ebuild,v 1.2 2002/12/09 04:37:26 manson Exp $

S=${WORKDIR}/star-1.5

DESCRIPTION="An enhanced (world's fastest) tar, as well as enhanced mt/rmt"
SRC_URI="ftp://ftp.fokus.gmd.de/pub/unix/star/alpha/${PN}-1.5a06.tar.bz2"
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/star.html"
KEYWORDS="x86 ppc sparc "
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}/DEFAULTS
	cp Defaults.linux Defaults.linux.orig
	sed -e 's:/opt/schily:/usr:g' -e 's:bin:root:g' Defaults.linux.orig > Defaults.linux
}

src_compile() {
	make COPTX="${CFLAGS}" || die
}

src_install() {
	make install INS_BASE=${D}/usr || die
	insinto /etc/default
	newins ${S}/rmt/rmt.dfl rmt
	
	# install mt as mt.star to not conflict with other packages
	mv ${D}/usr/bin/mt ${D}/usr/bin/mt.star

	dodoc BUILD COPYING Changelog AN-1.* README README.* PORTING TODO
	rm ${D}/usr/man/man1/match*
	dodir /usr/share/
	mv ${D}/usr/man/ ${D}/usr/share
	cd ${D}/usr/bin
	ln -s star ustar
	cd ${D}/usr/sbin
	mv rmt rmt.star
	dosym rmt.star /usr/sbin/rmt
	dosym rmt.1.gz /usr/share/man/man1/rmt.star.1.gz
}
