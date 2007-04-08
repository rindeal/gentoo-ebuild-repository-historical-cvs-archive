# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/saxpath/saxpath-1.0-r2.ebuild,v 1.10 2007/04/08 13:01:10 corsair Exp $

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A Simple API for XPath."
HOMEPAGE="http://saxpath.sourceforge.net/"
SRC_URI="mirror://sourceforge/saxpath/${P}.tar.gz"
LICENSE="saxpath"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"

RDEPEND=">=virtual/jre-1.4"
# doc needs ant-trax
# test needs ant-junit
DEPEND=">=virtual/jdk-1.4
	doc? ( || ( dev-java/ant-trax dev-java/ant-tasks ) )
	test? (
		dev-java/junit
		|| ( dev-java/ant-junit dev-java/ant-tasks )
	)"

S=${WORKDIR}/${P}-FCS

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm -v *.jar lib/*.jar || die

	mkdir src/conf
	cp "${FILESDIR}/MANIFEST.MF" src/conf

	use test && java-ant_rewrite-classpath

	use doc && ANT_TASKS="ant-trax"
}

EANT_BUILD_TARGET="package"
EANT_DOC_TARGET="doc javadoc"

src_test() {
	ANT_TASKS="ant-junit" eant -Dgentoo.classpath="$(java-pkg_getjar --build-only junit junit.jar)" \
		test
}

src_install() {
	java-pkg_dojar build/saxpath.jar

	if use doc; then
		# installs things other than javadoc too
		mv build/doc/javadoc build/doc/apidocs || die
		java-pkg_dohtml -r build/doc/*
		dosym /usr/share/doc/${PF}/html/{apidocs,api} || die
	fi
	use source && java-pkg_dosrc src/java/main/*
}
