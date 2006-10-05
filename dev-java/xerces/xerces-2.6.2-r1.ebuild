# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xerces/xerces-2.6.2-r1.ebuild,v 1.18 2006/10/05 17:03:13 gustavoz Exp $

inherit java-pkg eutils


S=${WORKDIR}/xerces-${PV//./_}
DESCRIPTION="The next generation of high performance, fully compliant XML parsers in the Apache Xerces family"
HOMEPAGE="http://xml.apache.org/xerces2-j/index.html"
SRC_URI="mirror://apache/xml/xerces-j/Xerces-J-src.${PV}.tar.gz
	mirror://apache/xml/xerces-j/Xerces-J-tools.${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="2"
KEYWORDS="x86 ppc amd64 ppc64"

DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.5.2"
RDEPEND=">=virtual/jre-1.3"
IUSE="doc"

src_unpack() {
	unpack ${A}
	mv tools ${S}
}

src_compile() {
	if use doc ; then
		sh build.sh jars sampjar javadocs || die "Compile failed."
	else
		sh build.sh jars sampjar || die "Compile failed."
	fi
}

src_install() {
	java-pkg_dojar build/x*.jar
	dodoc TODO STATUS README ISSUES
	dohtml Readme.html

	if use doc ; then
		dodir /usr/share/doc/${PF}
		cp -a samples ${D}/usr/share/doc/${PF}
		java-pkg_dohtml -r build/docs/javadocs
	fi
}
