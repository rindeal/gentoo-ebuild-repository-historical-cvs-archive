# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jai-bin/sun-jai-bin-1.1.2.01-r1.ebuild,v 1.3 2006/11/28 23:55:57 nichoj Exp $

inherit java-pkg

DESCRIPTION="JAI is a class library for managing images."
HOMEPAGE="http://java.sun.com/products/java-media/jai/"
SRC_URI="jai-${PV//./_}-lib-linux-i586.tar.gz"
LICENSE="sun-bcla-jai"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc x86"
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.3"
IUSE=""
RESTRICT="fetch"

S=${WORKDIR}/jai-${PV//./_}/

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from ${HOMEPAGE} and place it in ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	rm ${S}/LICENSE-jai.txt
}

src_compile() { :; }

src_install() {
	dodoc *.txt

	cd lib
	java-pkg_dojar *.jar
	use x86 && java-pkg_doso *.so
}

pkg_postinst() {
	einfo "This ebuild now installs into /opt/${PN} and /usr/share/${PN}"
	einfo 'To use you need to pass the following to java'
	use x86 && einfo '-Djava.library.path=$(java-config -i sun-jai-bin)'
	einfo '-classpath $(java-config -p sun-jai-bin)'
}

