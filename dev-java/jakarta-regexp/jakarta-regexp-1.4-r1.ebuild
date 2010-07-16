# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jakarta-regexp/jakarta-regexp-1.4-r1.ebuild,v 1.8 2010/07/16 20:04:33 grobian Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="100% Pure Java Regular Expression package"
SRC_URI="mirror://apache/jakarta/regexp/source/${P}.tar.gz"
HOMEPAGE="http://jakarta.apache.org/"
SLOT="1.4"
IUSE="doc source"
LICENSE="Apache-1.1"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm *.jar
	mkdir lib
}

src_compile() {
	eant $(use_doc javadocs) jar
}

src_install() {
	cd "${S}/build"
	java-pkg_newjar ${P}.jar ${PN}.jar
	cd "${S}"

	if use doc; then
		java-pkg_dojavadoc docs/api
		java-pkg_dohtml docs/*.html
		dodoc docs/*.txt
	fi

	use source && java-pkg_dosrc ${S}/src/java/*
}
