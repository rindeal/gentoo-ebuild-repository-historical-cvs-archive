# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xp/xp-0.5.ebuild,v 1.4 2005/02/17 17:47:09 luckyduck Exp $

inherit java-pkg

DESCRIPTION="XP is an XML 1.0 parser written in Java"
HOMEPAGE="http://www.jclark.com/xml/xp"
SRC_URI="ftp://ftp.jclark.com/pub/xml/xp.zip"
LICENSE="JamesClark"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"

IUSE="jikes doc"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	app-arch/unzip
	jikes? (>=dev-java/jikes-1.19 )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	rm -f xp.jar
	cp ${FILESDIR}/build.xml .
}

src_compile() {
	antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar xp.jar
	dodoc docs/copying.txt
	use doc && java-pkg_dohtml -r docs/*
}
