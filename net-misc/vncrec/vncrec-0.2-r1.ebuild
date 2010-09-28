# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vncrec/vncrec-0.2-r1.ebuild,v 1.1 2010/09/28 18:28:34 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="VNC session recorder and player"
HOMEPAGE="http://www.sodan.org/~penny/vncrec/"
SRC_URI="http://www.sodan.org/~penny/vncrec/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libXaw
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libXp
	x11-libs/libXpm
	x11-libs/libXt"
DEPEND="${RDEPEND}
	app-text/rman
	x11-misc/gccmakedep
	x11-misc/imake
	x11-proto/xextproto"

src_prepare() {
	epatch "${FILESDIR}"/${P}-includes.patch
	touch vncrec/vncrec.man
	sed -i Imakefile \
		-e '/make Makefiles/d' \
		|| die "sed Imakefile"
}

src_configure() {
	xmkmf -a || die
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		CCOPTIONS="${CXXFLAGS}" \
		EXTRA_LDOPTIONS="${LDFLAGS}" \
		World || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ChangeLog README README.vnc
}
