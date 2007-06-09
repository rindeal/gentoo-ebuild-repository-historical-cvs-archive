# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/yaggui/yaggui-0.9.2.ebuild,v 1.1 2007/06/09 11:35:15 caster Exp $

inherit java-pkg-2 java-ant-2

MY_P="${PN}-src-${PV}"

DESCRIPTION="Yet Another Gift GUI in java"
HOMEPAGE="http://yaggui.sourceforge.net/"
SRC_URI="mirror://sourceforge/yaggui/${MY_P/y/Y}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

COMMON_DEP="=dev-java/jgoodies-looks-1.2*"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}"

EANT_BUILD_TARGET="build-jar"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -e '/<unzip/d' -i build.xml || die
	rm -v lib/*.jar || die
	java-pkg_jar-from jgoodies-looks-1.2 looks.jar lib/plastic-1.1.2.jar
}

src_install() {
	java-pkg_newjar build/Yaggui.jar

	java-pkg_dolauncher ${PN} --main de.hampelratte.yaggui.Main

	dodoc doc/{changelog,Readme.txt} || die
}
