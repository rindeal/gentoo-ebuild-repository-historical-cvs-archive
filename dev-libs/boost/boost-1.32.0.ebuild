# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boost/boost-1.32.0.ebuild,v 1.13 2004/12/31 16:09:30 morfic Exp $

# This ebuild was generated by Ebuilder v0.4.
inherit python

BOOST_PV1=${PV/./_}
BOOST_PV=${BOOST_PV1/./_}
S="${WORKDIR}/${PN}_${BOOST_PV}"
DESCRIPTION="Boost Libraries for C++"
SRC_URI="mirror://sourceforge/boost/${PN}_${BOOST_PV}.tar.bz2"
HOMEPAGE="http://www.boost.org/"
LICENSE="freedist Boost-1.0"
SLOT="1"
IUSE="icc"

DEPEND="sys-devel/gcc
	dev-lang/python"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~ppc64"

if [ "${ARCH}" == "amd64" ]; then
	arch=
else
	arch=${ARCH}
fi

if use icc ; then
	BOOST_TOOLSET="intel-linux"
else
	BOOST_TOOLSET="gcc"
fi

BOOSTJAM=./tools/build/jam_src/bin.linux${arch}/bjam

src_compile() {
		python_version
		# Build bjam, a jam variant, which is used instead of make
		cd ${S}/tools/build/jam_src
		./build.sh ${BOOST_TOOLSET} || die "Failed to build bjam"
		cd ${S}

		# actual build
		${BOOSTJAM} \
			-sBOOST_ROOT=${S} \
			-sPYTHON_ROOT=/usr \
			-sPYTHON_VERSION=${PYVER} \
			-sTOOLS=${BOOST_TOOLSET} \
		--prefix=${D}/usr \
		--layout=system \
		stage

}

src_install () {
		# install build tools
		cd tools/build
		#do_whatever is too limiting here, need to move bunch of different stuff recursively
		dodir /usr/share/${PN}
		cp -a b* c* index.html v1/ v2/ ${D}/usr/share/${PN}
		cd ${S}

		${BOOSTJAM} ${MAKEOPTS} \
				-sBOOST_ROOT=${S} \
				-sPYTHON_ROOT=/usr \
				-sPYTHON_VERSION=${PYVER} \
				-sTOOLS=${BOOST_TOOLSET} \
		--prefix=${D}/usr \
		--layout=system \
		install

	# Install documentation; seems to be mostly under ${S}/lib
	   # install documentation
	dodoc README
	dohtml index.htm google_logo_40wht.gif c++boost.gif boost.css
	dohtml -A pdf -r more
	dohtml -r people
	dohtml -r doc

	find libs -type f -not -regex '^libs/[^/]*/build/.*' \
		-and -not -regex '^libs/.*/test[^/]?/.*' \
		-and -not -regex '^libs/.*/bench[^/]?/.*' \
		-and -not -regex '^libs/[^/]*/tools/.*' \
		-and -not -name \*.bat \
		-and -not -name Jamfile\* \
		-and -not -regex '^libs/[^/]*/src/.*' \
		-and -not -iname makefile \
		-and -not -name \*.mak \
		-and -not -name .\* \
		-and -not -name \*.dsw \
		-and -not -name \*.dsp \
		-exec \
	install -D -m0644 \{\} ${D}/usr/share/doc/${P}/html/\{\} \;

}

pkg_postinst () {
	#give them what they need to include while keeping this dir
	dosym /usr/include/boost-1_32/boost /usr/include/boost
}
