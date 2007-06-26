# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvb/libdvb-0.5.5.1-r3.ebuild,v 1.7 2007/06/26 18:33:10 pylon Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit eutils autotools

DESCRIPTION="libdvb package with added CAM library and libdvbmpegtools as well as dvb-mpegtools"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="http://www.metzlerbros.org/dvb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~x86"
IUSE="doc"

DEPEND="media-tv/linuxtv-dvb-headers"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-autotools.patch"
	epatch "${FILESDIR}/${P}-rename-analyze.patch"

	eautoreconf
}

src_install() {
	#einstall DESTDIR="${D}" || die "Install problem"
	insinto /usr/$(get_libdir)
	make DESTDIR="${D}" PREFIX=/usr LIBDIR=$(get_libdir) install || die "Problem at make install"

	cd ${D}/usr/bin
	mv dia dia_dvb

	cd ${S}
	if use doc; then
		insinto "/usr/share/doc/${PF}/sample_progs"
		doins sample_progs/*
		insinto "/usr/share/doc/${PF}/samplerc"
		doins samplerc/*
	fi

	elog "The script called 'dia' has been installed as dia_dvb"
	elog "so that it doesn't overwrite the binary of app-office/dia."
	elog "analyze has been renamed to analyze_mpg."

	dodoc README
}
