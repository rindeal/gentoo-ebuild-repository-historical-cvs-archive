# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/e/e-1.5.ebuild,v 1.1 2012/05/30 00:55:22 gienah Exp $

EAPI="4"

MY_PN="E"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="E is a theorem prover for full first-order logic with equality"
HOMEPAGE="http://www4.informatik.tu-muenchen.de/~schulz/E/E.html"
SRC_URI="http://www4.in.tum.de/~schulz/WORK/E_DOWNLOAD/V_${PV}/${MY_PN}.tgz -> ${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc examples isabelle"

RDEPEND=""
DEPEND="${RDEPEND}
		isabelle? (
			>=sci-mathematics/isabelle-2011.1-r1
		)"

S="${WORKDIR}"/${MY_PN}

src_configure() {
	./configure --prefix="${ROOT}usr" \
		--man-prefix="${ROOT}share/man" \
		|| die "E configure failed"

	sed -e "s@CFLAGS     = @CFLAGS     = ${CFLAGS} @" \
		-e "s@LD         = \$(CC) @LD         = \$(CC) ${LDFLAGS} @" \
		-i "${S}/Makefile.vars" \
		|| die "Could not add our flags to Makefile.vars"
}

src_install() {
	for i in "${S}/PROVER/eprover" \
		"${S}/PROVER/epclextract" \
		"${S}/PROVER/eproof" \
		"${S}/PROVER/eproof_ram" \
		"${S}/PROVER/eground" \
		"${S}/PROVER/e_ltb_runner" \
		"${S}/PROVER/e_axfilter" \
		"${S}/PROVER/checkproof" \
		"${S}/PROVER/ekb_create" \
		"${S}/PROVER/ekb_delete" \
		"${S}/PROVER/ekb_ginsert" \
		"${S}/PROVER/ekb_insert"
	do
		dobin "${i}"
	done

	for i in "${S}/DOC/man/eprover.1" \
		"${S}/DOC/man/epclextract.1" \
		"${S}/DOC/man/eproof.1" \
		"${S}/DOC/man/eproof_ram.1" \
		"${S}/DOC/man/eground.1" \
		"${S}/DOC/man/e_ltb_runner.1" \
		"${S}/DOC/man/e_axfilter.1" \
		"${S}/DOC/man/checkproof.1" \
		"${S}/DOC/man/ekb_create.1" \
		"${S}/DOC/man/ekb_delete.1" \
		"${S}/DOC/man/ekb_ginsert.1" \
		"${S}/DOC/man/ekb_insert.1"
	do
		doman "${i}"
	done

	if use doc; then
		pushd "${S}"/DOC || die "Could not cd to DOC"
		dodoc ANNOUNCE CREDITS DONE E-REMARKS E-REMARKS.english E-USERS \
			HISTORY NEWS PORTING ReadMe THINKME TODO TPTP_SUBMISSION \
			WISHLIST eprover.pdf
		dohtml *.html
		insinto /usr/share/doc/${PF}/html
		doins estyle.sty
		popd
	fi

	if use examples; then
		dodir /usr/share/${MY_PN}/examples
		insinto /usr/share/${MY_PN}/examples
		doins -r EXAMPLE_PROBLEMS
		doins -r SIMPLE_APPS
	fi

	if use isabelle; then
		ISABELLE_HOME="$(isabelle getenv ISABELLE_HOME | cut -d'=' -f 2)" \
			|| die "isabelle getenv ISABELLE_HOME failed"
		if [[ -z "${ISABELLE_HOME}" ]]; then
			die "ISABELLE_HOME empty"
		fi
		dodir "${ISABELLE_HOME}/contrib/${PN}-${PV}/etc"
		cat <<- EOF >> "${S}/settings"
			E_HOME="${ROOT}usr/bin"
			E_VERSION="${PV}"
		EOF
		insinto "${ISABELLE_HOME}/contrib/${PN}-${PV}/etc"
		doins "${S}/settings"
	fi
}

pkg_postinst() {
	if use isabelle; then
		if [ -f "${ROOT}etc/isabelle/components" ]; then
			if egrep "contrib/${PN}-[0-9.]*" "${ROOT}etc/isabelle/components"; then
				sed -e "/contrib\/${PN}-[0-9.]*/d" \
					-i "${ROOT}etc/isabelle/components"
			fi
			cat <<- EOF >> "${ROOT}etc/isabelle/components"
				contrib/${PN}-${PV}
			EOF
		fi
	fi
}

pkg_postrm() {
	if use isabelle; then
		if [ ! -f "${ROOT}usr/bin/eproof" ]; then
			if [ -f "${ROOT}etc/isabelle/components" ]; then
				# Note: this sed should only match the version of this ebuild
				# Which is what we want as we do not want to remove the line
				# of a new E being installed during an upgrade.
				sed -e "/contrib\/${PN}-${PV}/d" \
					-i "${ROOT}etc/isabelle/components"
			fi
		fi
	fi
}
