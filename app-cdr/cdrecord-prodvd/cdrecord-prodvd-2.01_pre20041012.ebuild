# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrecord-prodvd/cdrecord-prodvd-2.01_pre20041012.ebuild,v 1.1 2005/03/29 22:48:14 pylon Exp $

AMD64_FILENAME="${PN}-2.01-pre-x86_64-unknown-linux-gnu"

DESCRIPTION="Enhancement of cdrecord for writing DVDs"
HOMEPAGE="http://ftp.berlios.de/pub/cdrecord/ProDVD/"
SRC_URI="amd64? ( ftp://ftp.berlios.de/pub/cdrecord/ProDVD/${AMD64_FILENAME} )"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="uclibc"

DEPEND=">=app-cdr/cdrtools-2.01_alpha24
	!uclibc? ( sys-libs/glibc )"

S=${WORKDIR}

src_unpack() {
	use uclibc && die "binary package not compatible with uclibc"
	cp ${DISTDIR}/${A} ${WORKDIR}/
}

src_install() {
	dobin ${A}
	dosym ${A} /usr/bin/cdrecord-ProDVD
	dobin ${FILESDIR}/cdrecord-wrapper.sh
}

pkg_postinst() {
	echo
	einfo "For a license key of CDrecord-ProDVD please read"
	einfo "ftp://ftp.berlios.de/pub/cdrecord/ProDVD/README"
	einfo "or use cdrecord-wrapper.sh"
	echo
}
