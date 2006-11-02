# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/rebase/rebase-601-r1.ebuild,v 1.8 2006/11/02 20:19:00 grobian Exp $

DESCRIPTION="A restriction enzyme database"
LICENSE="public-domain"
HOMEPAGE="http://rebase.neb.com"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
# Minimal build keeps only the indexed files (if applicable) and the
# documentation. The non-indexed database is not installed.
IUSE="emboss minimal"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"

DEPEND="emboss? ( >=sci-biology/emboss-3.0.0-r1 )"

src_compile() {
	if use emboss; then
		echo
		einfo "Indexing ${PN} for usage with EMBOSS."
		mkdir REBASE
		EMBOSS_DATA=. rebaseextract -auto -infile withrefm.${PV} \
			-protofile proto.${PV} || die "Indexing ${PN} failed."
		echo
	fi
}

src_install() {
	if ! use minimal; then
		insinto /usr/share/${PN}
		doins withrefm.${PV} proto.${PV} || die \
			"Failed to install raw database."
	fi
	newdoc REBASE.DOC README || die "Failed to install documentation."
	if use emboss; then
		insinto /usr/share/EMBOSS/data/REBASE
		doins REBASE/{embossre.enz,embossre.ref,embossre.sup} || die \
			"Failed to install EMBOSS data files."
		insinto /usr/share/EMBOSS/data
		doins embossre.equ || die "Failed to install enzyme prototypes file."
	fi
}
