# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tiff/tiff-3.7.2.ebuild,v 1.14 2006/05/01 03:29:28 nerdboy Exp $

inherit eutils

DESCRIPTION="Library for manipulation of TIFF (Tag Image File Format) images."
HOMEPAGE="http://www.libtiff.org/"
SRC_URI="ftp://ftp.remotesensing.org/pub/libtiff/old/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=">=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.3-r2"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${P}-buffer_check.patch || die "buffer_check patch failed"
}

src_compile() {
	local myconf
	myconf="--without-x"
	use ppc-macos && myconf=" --disable-cxx"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc README TODO VERSION
}
