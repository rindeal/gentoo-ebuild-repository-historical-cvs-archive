# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/dansguardian/dansguardian-2.7.2.ebuild,v 1.1 2003/07/31 05:32:18 method Exp $

DESCRIPTION="Web content filtering via proxy"
HOMEPAGE="http://dansguardian.org"
P="DansGuardian-${PV}"
SRC_URI="http://mirror.dansguardian.org/downloads/2/Alpha/${P}-0.source.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="net-www/squid"
S=${WORKDIR}/${P}-0

src_compile() {
	./configure \
		--prefix= \
		--installprefix=${D} \
		--mandir=/usr/share/man/ || die "./configure failed"
	emake || die
}

src_install() {
	make install || die

	dodir /etc/init.d
	cp ${FILESDIR}/dansguardian.init ${D}/etc/init.d

	rm -rf ${D}/etc/rc.d

	einfo "Fixing location of initscript"
	sed 's/rc.d\///' ${D}/etc/dansguardian/logrotation > ${D}/etc/dansguardian/logrotation.fixed
	mv -f ${D}/etc/dansguardian/logrotation.fixed ${D}/etc/dansguardian/logrotation

	dodoc INSTALL README LICENSE
}
