# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/timezone-data/timezone-data-2006g.ebuild,v 1.3 2006/06/27 20:32:43 the_paya Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Timezone data (/usr/share/zoneinfo) and utilities (tzselect/zic/zdump)"
HOMEPAGE="ftp://elsie.nci.nih.gov/pub/"
SRC_URI="ftp://elsie.nci.nih.gov/pub/tzdata${PV}.tar.gz
	ftp://elsie.nci.nih.gov/pub/tzcode${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 m68k mips ppc ~ppc64 s390 sh sparc ~x86 ~x86-fbsd"
IUSE="elibc_FreeBSD"

DEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PN}-2005n-makefile.patch
}

src_compile() {
	tc-export CC
	# Fixes bug #138251.
	use elibc_FreeBSD && append-flags -DSTD_INSPIRED
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die
	rm -rf "${D}"/usr/share/zoneinfo-leaps
	dodoc README Theory
	dohtml *.htm *.jpg
}

pkg_postinst() {
	if [[ ! -e ${ROOT}/etc/localtime ]] ; then
		ewarn "Please remember to set your timezone using the zic command."
		rm -f "${ROOT}"/etc/localtime
		ln -s ../usr/share/zoneinfo/Factory "${ROOT}"/etc/localtime
	fi
}
