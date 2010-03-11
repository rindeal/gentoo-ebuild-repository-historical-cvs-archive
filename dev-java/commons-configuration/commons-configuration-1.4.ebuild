# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-configuration/commons-configuration-1.4.ebuild,v 1.5 2010/03/11 22:44:30 sping Exp $

EAPI=1
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Java library for reading configuration data from a variety of sources."
HOMEPAGE="http://commons.apache.org/configuration/"
SRC_URI="http://archive.apache.org/dist/commons/configuration/source/${P}-src.tar.gz"

COMMON_DEPENDS="
	>=dev-java/commons-beanutils-1.7.0:1.7
	>=dev-java/commons-codec-1.3:0
	>=dev-java/commons-collections-3.1:0
	>=dev-java/commons-digester-1.6:0
	>=dev-java/commons-jxpath-1.2:0
	>=dev-java/commons-lang-2.3:2.1
	>=dev-java/commons-logging-1.0.4:0
	>=dev-java/commons-httpclient-3.0:3
	dev-java/servletapi:2.4"

DEPEND=">=virtual/jdk-1.4
	${COMMON_DEPENDS}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPENDS}"
LICENSE="Apache-2.0"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

S="${WORKDIR}/${P}-src"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Tweak build classpath and don't automatically run tests
	epatch "${FILESDIR}/${P}-gentoo.patch"

	java-ant_rewrite-classpath
}

EANT_GENTOO_CLASSPATH="
	commons-beanutils-1.7
	commons-codec
	commons-collections
	commons-digester
	commons-jxpath
	commons-lang-2.1
	commons-logging
	commons-httpclient-3
	servletapi-2.4"

# Would need mockobjects with j2ee support which we don't have
# Check overlay for ebuild with test support
RESTRICT="test"

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar
	dodoc RELEASE-NOTES.txt || die
	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
