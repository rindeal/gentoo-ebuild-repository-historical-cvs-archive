# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/xephem/xephem-3.6.2-r1.ebuild,v 1.2 2005/04/21 10:10:50 phosphan Exp $

DESCRIPTION="XEphem is the X Windows Ephemeris, and provides a scientific-grade solar system model, star charts, sky views, plus a whole lot more."
SRC_URI="http://www.clearskyinstitute.com/xephem/${PN}-${PV}.tar.gz"
HOMEPAGE="http://www.clearskyinstitute.com/xephem"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""
SLOT="0"
LICENSE="as-is"
DEPEND="x11-libs/openmotif"


src_unpack() {
	unpack ${A}
	cd ${S}
	for i in libastro/Makefile libip/Makefile libjpegd/Makefile \
		liblilxml/Makefile GUI/xephem/Makefile.simple ; do
		einfo "Fixing CFLAGS in $i"
		sed -e "s~^CFLAGS[ ]*=\(.*\)-O2\(.*\)~CFLAGS= \1 \2 ${CFLAGS}~" -i $i \
			|| die "sed failed"
	done
	sed -e 's~^CFLAGS[ ]*=\(.*\)$(CLDFLAGS)\(.*\)~CFLAGS=\1 \2~' \
		-i GUI/xephem/Makefile.simple
}

src_compile() {

	cd libastro
	emake || die

	for i in libip liblilxml libjpegd; do
		echo "going into ${i}"
		emake || die
	done

	cd ../GUI/xephem
	emake CLDFLAGS="${LDFLAGS}" -f Makefile.simple || die

}

src_install() {

	into /usr
	dobin ${S}/GUI/xephem/xephem
	cd ${S}/GUI/xephem
	for i in $(find . -type d); do
		insinto /usr/share/${PN}/${i}
		doins ${i}/*
	done

	echo > ${S}/XEphem "XEphem.ShareDir: /usr/share/${PN}"
	insinto /usr/lib/X11/app-defaults/
	doins ${S}/XEphem

	cd ${S}
	dodoc Copyright README INSTALL
	doman ${S}/xephem.1
}
