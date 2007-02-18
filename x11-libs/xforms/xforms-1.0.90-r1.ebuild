# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xforms/xforms-1.0.90-r1.ebuild,v 1.9 2007/02/18 16:24:14 phreak Exp $

inherit autotools

DESCRIPTION="A graphical user interface toolkit for X"
HOMEPAGE="http://www.nongnu.org/xforms/"
SRC_URI="http://savannah.nongnu.org/download/xforms/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm ppc ~ppc-macos ~ppc64 sh sparc x86"
IUSE="opengl"

DEPEND=" || (
				(
					x11-libs/libICE
					x11-libs/libXpm
					x11-libs/libSM
					x11-proto/xproto
				)
				virtual/x11
			 )
	opengl? ( virtual/opengl )
	media-libs/jpeg"


src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-as-needed.patch
	epatch "${FILESDIR}"/${P}-Makefile.am.patch

	eautoreconf
}

src_compile () {
	local myopts
	use opengl || myopts="--disable-gl"

	econf ${myopts} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog INSTALL NEWS README
}
