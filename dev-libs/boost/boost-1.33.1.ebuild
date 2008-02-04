# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boost/boost-1.33.1.ebuild,v 1.15 2008/02/04 20:38:41 grobian Exp $

# This ebuild was generated by Ebuilder v0.4.
inherit python distutils multilib eutils

DESCRIPTION="Boost Libraries for C++"
HOMEPAGE="http://www.boost.org/"
BOOST_PV1=${PV/./_}
BOOST_PV=${BOOST_PV1/./_}
SRC_URI="mirror://gentoo/${PN}_${BOOST_PV}.tar.bz2 \
		mirror://sourceforge/boost/${PN}_${BOOST_PV}.tar.bz2"
LICENSE="freedist Boost-1.0"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="bcp bjam debug doc pyste static threads threadsonly"

DEPEND="sys-devel/gcc
	dev-lang/python"

RDEPEND="pyste? ( dev-cpp/gccxml dev-python/elementtree )
		${DEPEND}"

S="${WORKDIR}/${PN}_${BOOST_PV}"

pkg_setup() {

	if [ "${ARCH}" == "amd64" ]; then
		arch=
	else
		arch=${ARCH}
	fi

	BOOST_TOOLSET="gcc"
	TOOLSET_NAME="gcc"
	SOSUFFIX="so"

	if use static ; then
		BUILD="release <runtime-link>static"
	else
		BUILD="release <runtime-link>dynamic"
	fi

	if use debug ; then
		BUILD="${BUILD} debug"
	fi

	if use threads && use threadsonly ; then
		BUILD="${BUILD} <threading>multi"
	fi

	if use threads && ! use threadsonly ; then
		BUILD="${BUILD} <threading>single/multi"
	fi

	if ! use threads ; then
		BUILD="${BUILD} <threading>single"
	fi

	BOOSTJAM="${S}/tools/build/jam_src/bin.*/bjam"

	# we dont like what get_number_of_jobs does, so we borrow what counts to us,
	# thanks H?kan Wessberg <nacka-gentoo@refug.org>, bug #13565

	if [ "`egrep "^[[:space:]]*MAKEOPTS=" /etc/make.conf | wc -l`" -gt 0 ]; then
		ADMINOPTS="`egrep "^[[:space:]]*MAKEOPTS=" /etc/make.conf | cut -d= -f2 | sed 's/\"//g'`"
		ADMINPARAM="`echo ${ADMINOPTS} | gawk '{match($0, /-j *[0-9]*/, opt); print opt[0]}'`"
		NUMJOBS="${ADMINPARAM}"
	fi

	python_version

}

src_compile() {
		# Build bjam, a jam variant, which is used instead of make
		cd "${S}/tools/build/jam_src"
		./build.sh ${BOOST_TOOLSET} || die "Failed to build bjam"
		cd "${S}"

		#Fixing boost with threads on alpha. Thanks to ibm <imirkin@mit.edu>
		if use threads && [ "${ARCH}" == "alpha" ]; then
			epatch ${FILESDIR}/boost-alpha-threads.patch
		fi

				${BOOSTJAM} ${NUMJOBS} -sBOOST_ROOT="${S}" \
				-sPYTHON_ROOT=/usr \
				-sPYTHON_VERSION=${PYVER} \
				-sTOOLS=${BOOST_TOOLSET} \
				-sBUILD="${BUILD}" \
				--prefix=${D}/usr \
				--layout=system

				${BOOSTJAM} ${NUMJOBS} -sBOOST_ROOT="${S}" \
				-sPYTHON_ROOT=/usr \
				-sPYTHON_VERSION=${PYVER} \
				-sTOOLS=${BOOST_TOOLSET} \
				-sBUILD="${BUILD}" \
				--prefix=${D}/usr \
				--layout=system

		if use pyste; then
			cd "${S}/libs/python/pyste/install"
			distutils_src_compile
		fi

		if use bcp; then
			cd "${S}/tools/bcp/"
			${BOOSTJAM} || die "Building bcp failed"
		fi
}

src_install () {
		# install build tools
		cd "${S}/tools/build"
		#do_whatever is too limiting here, need to move bunch of different stuff recursively
		dodir /usr/share/boost-build
		insinto /usr/share/boost-build
		cp -pPR index.html v1/ v2/ "${D}/usr/share/boost-build" || die "failed to install docs"
		cd "${S}"

			${BOOSTJAM}	${NUMJOBS} -sBOOST_ROOT="${S}" \
			-sPYTHON_ROOT=/usr \
			-sPYTHON_VERSION=${PYVER} \
			-sTOOLS=${BOOST_TOOLSET} \
			-sBUILD="${BUILD}" \
			--prefix="${D}/usr" \
			--layout=system \
			install || die "Install failed"

	# Install documentation; seems to be mostly under ${S}/lib

	if use doc ; then
		dodoc README
		dohtml 	index.htm google_logo_40wht.gif c++boost.gif boost.css \
				-A pdf -r more-r people -r doc

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
		install -D -m0644 \{\} "${D}/usr/share/doc/${PF}/html/{}" \;
	fi
		#and finally set "default" links to -gcc-mt versions
		cd "${D}/usr/lib"

		for fn in `ls -1 *.${SOSUFFIX}| cut -d- -f1 | sort | uniq`; do
			if [ -f "$fn.${SOSUFFIX}" ] ; then
				dosym "$fn.${SOSUFFIX}" "/usr/lib/$fn-${TOOLSET_NAME}.${SOSUFFIX}"
			fi
			if [ -f "$fn-mt.${SOSUFFIX}" ] ; then
				dosym "$fn-mt.${SOSUFFIX}" "/usr/lib/$fn-${TOOLSET_NAME}-mt.${SOSUFFIX}"
			fi
			if [ -f "$fn-d.${SOSUFFIX}" ] ; then
				dosym "$fn-d.${SOSUFFIX}" "/usr/lib/$fn-${TOOLSET_NAME}-d.${SOSUFFIX}"
			fi
			if [ -f "$fn-mt-d.${SOSUFFIX}" ] ; then
				dosym "$fn-mt-d.${SOSUFFIX}" "/usr/lib/$fn-${TOOLSET_NAME}-mt-d.${SOSUFFIX}"
			fi
		done

		for fn in `ls -1 *.a| cut -d- -f1 | sort | uniq`; do
			if [ -f "$fn.a" ] ; then
				dosym "$fn.a" "/usr/lib/$fn-${TOOLSET_NAME}.a"
			fi
			if [ -f "$fn-mt.a" ] ; then
				dosym "$fn-mt.a" "/usr/lib/$fn-${TOOLSET_NAME}-mt.a"
			fi
			if [ -f "$fn-d.a" ] ; then
				dosym "$fn-d.a" "/usr/lib/$fn-${TOOLSET_NAME}-d.a"
			fi
			if [ -f "$fn-mt-d.a" ] ; then
				dosym "$fn-mt-d.a" "/usr/lib/$fn-${TOOLSET_NAME}-mt-d.a"
			fi
		done

	[[ $(get_libdir) == "lib" ]] || mv "${D}/usr/lib" "${D}/usr/$(get_libdir)"

	if use pyste; then
		cd "${S}/libs/python/pyste/install"
		distutils_src_install
	fi

	if use bcp; then
		cd "${S}/tools/bcp/run/"
		exeinto /usr/bin
		doexe bcp || die "bcp install failed"
	fi

	if use bjam; then
		cd "${S}"/tools/build/jam_src/bin.*/
		exeinto /usr/bin
		doexe bjam || die "bjam install failed"
	fi
}
