# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lincvs/lincvs-1.3.2.ebuild,v 1.1 2004/06/01 19:45:37 carlo Exp $

inherit kde-functions

IUSE="kde"

DESCRIPTION="A graphical CVS client."
SRC_URI="http://ppprs1.phy.tu-dresden.de/~trogisch/${PN}/download/20_LinCVS/hl_${P}/${P}-0-generic-src.tgz"
HOMEPAGE="http://www.lincvs.org"

SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
LICENSE="GPL-2"

DEPEND="kde? ( >=kde-base/kdelibs-3 )
	>=dev-util/cvs-1.11.16"

RDEPEND="${DEPEND}
	dev-util/cvs"

need-qt 3

src_compile() {
	qmake -o Makefile lincvs.pro
	sed -e "s/^\tstrip/#\tstrip/" -i Makefile
	sed -i -e "s/CFLAGS   = -pipe -Wall -W -O2/CFLAGS   = ${CFLAGS} -Wall -W/" Makefile
	sed -i -e "s/CXXFLAGS = -pipe -Wall -W -O2/CXXFLAGS = ${CXXFLAGS} -Wall -W/" Makefile
	emake || die "make failed"
}

src_install() {
	emake install || die "make install failed"
	echo "#!/bin/sh" > ${S}/LinCVS/lincvs
	echo "exec /usr/share/LinCVS/AppRun" >> ${S}/LinCVS/lincvs
	dobin LinCVS/lincvs
	rm ${S}/LinCVS/lincvs
	dodir /usr/share
	cp -pr ${S}/LinCVS ${D}/usr/share
	fperms 644 /usr/share/LinCVS/AppI* /usr/share/LinCVS/Messages/* \
		/usr/share/LinCVS/Help/* /usr/share/LinCVS/Help/Translations/*/*
	fperms 755 /usr/share/LinCVS/AppRun /usr/share/LinCVS/Tools/*
	dodoc AUTHORS BUGS.txt ChangeLog COPYING LICENSE NEWS THANKS VERSION
}
