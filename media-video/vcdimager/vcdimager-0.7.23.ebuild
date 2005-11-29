# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vcdimager/vcdimager-0.7.23.ebuild,v 1.2 2005/11/29 00:40:31 weeve Exp $

inherit eutils libtool

DESCRIPTION="GNU VCDimager"
HOMEPAGE="http://www.vcdimager.org/"
SRC_URI="http://www.vcdimager.org/pub/vcdimager/vcdimager-0.7/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="xml2 minimal"

RDEPEND=">=dev-libs/libcdio-0.71
	!minimal? ( dev-libs/popt )
	xml2? ( >=dev-libs/libxml2-2.5.11 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	local myconf

	# We disable the xmltest because the configure script includes differently
	# than the actual XML-frontend C files.
	use xml2 && myconf="${myconf} --with-xml-prefix=/usr --disable-xmltest"
	use xml2 || myconf="${myconf} --without-xml-frontend"

	econf \
		$(use_with !minimal cli-frontends) \
		${myconf} \
		--disable-dependency-tracking || die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS BUGS ChangeLog FAQ HACKING NEWS README THANKS TODO
}

src_test() { :; }
