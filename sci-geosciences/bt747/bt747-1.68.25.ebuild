# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/bt747/bt747-1.68.25.ebuild,v 1.1 2009/08/21 10:05:04 bangert Exp $
EAPI=2

WANT_ANT_TASKS="ant-nodeps"

inherit java-utils-2 java-pkg-2 java-ant-2

MY_PN=BT747
MY_P=${MY_PN}_${PV}

DESCRIPTION="MTK GPS Datalogger Device Control"
HOMEPAGE="http://bt747.free.fr/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}_full.zip"

LICENSE="GPL-3"
SLOT="1"
KEYWORDS="~x86"
IUSE=""

COMMON_DEP="dev-java/rxtx:2
	dev-java/swing-layout:1
	dev-java/jcalendar:1.2"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	${COMMON_DEP}"

EANT_BUILD_TARGET="dist.j2se"
EANT_EXTRA_ARGS="-Dskip.proguard=yes
	-Drxtxcomm.jar=lib/RXTXcomm.jar
	-Dswinglayout.jar=lib/swing-layout.jar
	-Djcalendar.jar=lib/jcalendar.jar"

S="${WORKDIR}"

java_prepare() {
	rm -rf dist
	cd lib
	rm -rf r* W* c* swing-* w* jc*
	java-pkg_jar-from rxtx-2
	java-pkg_jar-from swing-layout-1
	java-pkg_jar-from jcalendar-1.2
}

src_install() {
	dodoc ChangeLog.txt README.txt
	java-pkg_dojar dist/*.jar
	java-pkg_jarinto /opt/${PN}-${SLOT}/lib
	java-pkg_newjar lib/jopt-simple-2.4.1.jar jopt-simple.jar
	java-pkg_dojar lib/swingx*.jar
	java-pkg_dolauncher ${PN} --main bt747.j2se_view.BT747Main \
		--java-args="-Xmx192m"
}
