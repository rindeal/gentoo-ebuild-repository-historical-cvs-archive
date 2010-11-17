# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/cns/cns-1.3.ebuild,v 1.1 2010/11/17 13:10:04 jlec Exp $

EAPI="3"

inherit eutils fortran toolchain-funcs versionator flag-o-matic

MY_PN="${PN}_solve"
MY_PV="$(delete_version_separator 2)"
MY_P="${MY_PN}_${MY_PV}"

DESCRIPTION="Crystallography and NMR System"
HOMEPAGE="http://cns.csb.yale.edu/"
SRC_URI="${MY_P}_all.tar.gz
	aria? ( aria2.3.1.tar.gz )"

SLOT="0"
LICENSE="cns"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="aria openmp"

RDEPEND="app-shells/tcsh"
DEPEND="${RDEPEND}"
PDEPEND="aria? ( ~sci-chemistry/aria-2.3.1 )"

RESTRICT="fetch"
S="${WORKDIR}/${MY_P}"

FORTRAN="gfortran ifc"

pkg_nofetch() {
	elog "Fill out the form at http://cns.csb.yale.edu/cns_request/"
	use aria && elog "and http://aria.pasteur.fr/"
	elog "and place these files:"
	elog ${A}
	elog "in ${DISTDIR}."
}

pkg_setup() {
	fortran_pkg_setup

	if [[ $(tc-getCC) == *gcc* ]] &&
		( [[ $(gcc-major-version)$(gcc-minor-version) -lt 42 ]] ||
		! built_with_use sys-devel/gcc openmp )
	then
		ewarn "You are using gcc and OpenMP is only available with gcc >= 4.2 "
		ewarn "Switch CC to an OpenMP capable compiler"
	fi
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PV}-gentoo.patch \
		"${FILESDIR}"/${PV}-delete.patch

	if use aria; then
		pushd "${WORKDIR}"/aria* >& /dev/null
			# Update the cns sources in aria for version 1.2.1
			epatch "${FILESDIR}"/1.2.1-aria2.3.patch

			# Update the code with aria specific things
			cp -rf cns/src/* "${S}"/source/
		popd >& /dev/null
	fi

	# the code uses Intel-compiler-specific directives
	if [[ ${FORTRANC} == gfortran ]]; then
		use openmp && \
			OMPLIB="-lgomp" && append-flags -fopenmp
		COMP="gfortran"
		use amd64 && \
			append-fflags -fdefault-integer-8
	else
		use openmp && OMPLIB="-liomp5" && \
			append-flags -openmp && append-ldflags -openmp
		COMP="ifort"
		use amd64 && append-fflags -i8
		append-fflags -Vaxlib
		append-ldflags -Vaxlib
	fi

	use amd64 && \
		append-cflags "-DINTEGER='long long int'"

	# Set up location for the build directory
	# Uses obsolete `sort` syntax, so we set _POSIX2_VERSION
	cp "${FILESDIR}"/cns_solve_env_sh-${PV} "${T}"/cns_solve_env_sh || die
	sed -i \
		-e "s:_CNSsolve_location_:${S}:g" \
		-e "17 s:\(.*\):\1\nsetenv _POSIX2_VERSION 199209:g" \
		"${S}"/cns_solve_env
	sed -i \
		-e "s:_CNSsolve_location_:${S}:g" \
		-e "17 s:\(.*\):\1\nexport _POSIX2_VERSION; _POSIX2_VERSION=199209:g" \
		"${T}"/cns_solve_env_sh

	ebegin "Fixing shebangs..."
		find "${S}" -type f \
			-exec sed "s:/bin/csh:${EPREFIX}/bin/csh:g" -i '{}' \; || die
		find . -name "Makefile*" \
			-exec \
				sed \
					-e "s:^SHELL=/bin/sh:SHELL=${EPREFIX}/bin/sh:g" \
					-e "s:/bin/ls:ls:g" \
					-e "s:/bin/rm:rm:g" \
					-i '{}' \; || die
	eend
}

src_compile() {
	local GLOBALS
	local MALIGN

	# Set up the compiler to use
	pushd instlib/machine/unsupported/g77-unix 2>/dev/null
	ln -s Makefile.header Makefile.header.${FORTRANC} || die
	popd 2>/dev/null

	# make install really means build, since it's expected to be used in-place
	# -j1 doesn't mean we do no respect MAKEOPTS!
	emake -j1 \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		F77="${FORTRANC}" \
		LD="${FORTRANC}" \
		CCFLAGS="${CFLAGS} -DCNS_ARCH_TYPE_\$(CNS_ARCH_TYPE) \$(EXT_CCFLAGS)" \
		CXXFLAGS="${CXXFLAGS} -DCNS_ARCH_TYPE_\$(CNS_ARCH_TYPE) \$(EXT_CCFLAGS)" \
		LDFLAGS="${LDFLAGS}" \
		F77OPT="${FFLAGS:- -O2} ${MALIGN}" \
		F77STD="${GLOBALS}" \
		OMPLIB="${OMPLIB}" \
		compiler="${COMP}" \
		install \
		|| die "emake failed"

}

src_test() {
	# We need to force on g77 manually, because we can't get aliases working
	# when we source in a -c
	einfo "Running tests ..."
	sh -c \
		"export CNS_G77=ON; source ${T}/cns_solve_env_sh; make run_tests" \
		|| die "tests failed"
	einfo "Displaying test results ..."
	cat "${S}"/*_g77/test/*.diff-test
}

src_install() {
	cat >> "${T}"/66cns <<- EOF
	CNS_SOLVE="${EPREFIX}/usr"
	CNS_ROOT="${EPREFIX}/usr"
	CNS_DATA="${EPREFIX}/usr/share/cns"
	CNS_DOC="${EPREFIX}/usr/share/doc/cns-1.3"
	CNS_LIB="${EPREFIX}/usr/share/cns/libraries"
	CNS_MODULE="${EPREFIX}/usr/share/cns/modules"
	CNS_TOPPAR="${EPREFIX}/usr/share/cns/libraries/toppar"
	CNS_CONFDB="${EPREFIX}/usr/share/cns/libraries/confdb"
	CNS_XTALLIB="${EPREFIX}/usr/share/cns/libraries/xtal"
	CNS_NMRLIB="${EPREFIX}/usr/share/cns/libraries/nmr"
	CNS_XRAYLIB="${EPREFIX}/usr/share/cns/libraries/xray"
	CNS_XTALMODULE="${EPREFIX}/usr/share/cns/modules/xtal"
	CNS_NMRMODULE="${EPREFIX}/usr/share/cns/modules/nmr"
	CNS_HELPLIB="${EPREFIX}/usr/share/cns/helplib"
	EOF

	doenvd "${T}"/66cns || die

	# Don't want to install this
	rm -f "${S}"/*linux*/utils/Makefile

	sed -i \
		-e "s:\$CNS_SOLVE/doc/:\$CNS_SOLVE/share/doc/${PF}/:g" \
		"${S}"/bin/cns_web || die

	newbin "${S}"/*linux*/bin/cns_solve* cns_solve \
		|| die "install cns_solve failed"

	# Can be run by either cns_solve or cns
	dosym cns_solve /usr/bin/cns

	dobin \
		"${S}"/*linux*/utils/* \
		"${S}"/bin/cns_{edit,header,import_cif,transfer,web} || die "install bin failed"

	insinto /usr/share/cns
	doins -r "${S}"/libraries "${S}"/modules "${S}"/helplib "${S}"/bin/cns_info || die

	dohtml \
		-A iq,cgi,csh,cv,def,fm,gif,hkl,inp,jpeg,lib,link,list,mask,mtf,param,pdb,pdf,pl,ps,sc,sca,sdb,seq,tbl,top \
		-f all_cns_info_template,omac,def \
		-r doc/html/* || die
	# Conflits with app-text/dos2unix
	rm -f "${D}"/usr/bin/dos2unix || die
}

pkg_info() {
	if use openmp; then
		elog "Set OMP_NUM_THREADS to the number of threads you want."
		elog "If you get segfaults on large structures, set the GOMP_STACKSIZE"
		elog "variable if using gcc (16384 should be good)."
	fi
}

pkg_postinst() {
	pkg_info
}
