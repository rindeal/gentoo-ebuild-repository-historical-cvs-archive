# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Damon Conway <kabau@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ion/ion-20011109-r1.ebuild,v 1.1 2001/12/14 00:18:33 kabau Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A keyboard-based window manager"
SRC_URI="http://www.students.tut.fi/~tuomov/dl/${P}.tar.gz"
HOMEPAGE="http://www.students.tut.fi/~tuomov/ion/"
DEPEND="virtual/glibc"
RDEPEND="virtual/x11"

src_compile() {
	cd ${S}

	# Edit system.mk
	cp system.mk system.mk.new
	sed -e 's:PREFIX=/usr/local:PREFIX=/usr:' \
		-e 's:ETCDIR=$(PREFIX)/etc:ETCDIR=/etc/X11:' \
		-e 's:$(PREFIX)/man:$(PREFIX)/share/man:' \
		-e 's:$(PREFIX)/doc:$(PREFIX)/share/doc:' \
		-e 's:#HAS_SYSTEM_ASPRINTF=1:HAS_SYSTEM_ASPRINTF=1:' \
		-e 's:#INSTALL=install -c:INSTALL=install -c:' \
		-e 's:INSTALL=install *$:#INSTALL=install:' \
		system.mk.new > system.mk

	cp Makefile Makefile.new
	sed -e 's:$(DOCDIR)/ion:$(DOCDIR)/${P}:g' Makefile.new > Makefile

	make depend || die
	emake || die
}

src_install () {
	make PREFIX=${D}/usr ETCDIR=${D}/etc/X11 install || die
}

pkg_postinst () {
	einfo "Configuration documentation can be found in these places:"
	einfo "/usr/share/doc/${P}/config.txt"
	einfo "http://www.students.tut.fi/~tuomov/ion/resources.html"
}
