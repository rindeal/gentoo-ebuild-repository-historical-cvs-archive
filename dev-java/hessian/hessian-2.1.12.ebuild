# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/hessian/hessian-2.1.12.ebuild,v 1.2 2005/10/21 14:32:40 betelgeuse Exp $

inherit java-pkg

DESCRIPTION="The Hessian binary web service protocol makes web services usable without requiring a large framework, and without learning yet another alphabet soup of protocols."
HOMEPAGE="http://www.caucho.com/hessian/"
SRC_URI="http://www.caucho.com/hessian/download/${P}-src.jar"

LICENSE="Apache-1.1"
SLOT="2.1"
KEYWORDS="~x86"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
		jikes? ( dev-java/jikes )
		source? ( app-arch/zip )
		dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4
		=dev-java/servletapi-2.3*"

src_unpack() {
	jar xvf ${DISTDIR}/${A}

	# We need to move things around a bit
	mkdir -p ${S}/src
	mv com ${S}/src

	cd ${S}
	# No included ant script! Bad Java developer, bad!
	cp ${FILESDIR}/build-${PVR}.xml build.xml

	# Populate classpath
	echo "classpath=$(java-pkg_getjars servletapi-2.3)" >> build.properties
}

src_compile() {
	local antflags="-Dproject.name=${PN} jar"
	use jikes && antflags="-Dbuild.compiler=jikes ${antflags}"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	use doc && java-pkg_dohtml -r dist/doc/api
	use source && java-pkg_dosrc src/*
}
