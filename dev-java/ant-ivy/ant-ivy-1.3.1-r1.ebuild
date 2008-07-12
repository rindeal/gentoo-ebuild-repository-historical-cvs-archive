# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-ivy/ant-ivy-1.3.1-r1.ebuild,v 1.2 2008/07/12 15:58:36 betelgeuse Exp $

inherit java-pkg-2 java-ant-2 eutils

MY_PN=${PN##*-}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Ivy is a free java based dependency manager"
HOMEPAGE="http://jayasoft.org/ivy"
SRC_URI="http://jayasoft.org/downloads/ivy/1.3.1/${MY_P}-src.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc source"

COMMON_DEP="
	dev-java/ant-core
	=dev-java/commons-cli-1*
	=dev-java/commons-httpclient-3*
	dev-java/commons-logging
	=dev-java/jakarta-oro-2.0*"
DEPEND="
	>=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

S=${WORKDIR}/${MY_P}

# Rewrites examples... bad
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${MY_P}-noresolve.patch"
	epatch "${FILESDIR}/${MY_P}-tasks.patch"

	mkdir "${S}/lib"
	java-pkg_jar-from --into lib commons-cli-1,commons-httpclient-3,commons-logging,ant-core,jakarta-oro-2.0

	java-ant_bsfix_one build.xml
}

src_install() {
	java-pkg_dojar build/artifact/${MY_PN}.jar
	dodir /usr/share/ant-core/lib
	dosym /usr/share/${PN}/lib/${MY_PN}.jar /usr/share/ant-core/lib/${PN}.jar
	use doc && java-pkg_dojavadoc doc/build/api
	use source && java-pkg_dosrc src/java/*
}

RESTRICT="test" # fail because of a missing file

src_test() {
	java-pkg_jar-from --into lib junit
	ANT_TASKS="ant-junit" eant test || die "Junit tests failed"
}
