# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngcrush/pngcrush-1.7.17-r1.ebuild,v 1.1 2011/10/08 19:12:43 hanno Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="Portable Network Graphics (PNG) optimizing utility"
HOMEPAGE="http://pmt.sourceforge.net/pngcrush/"
SRC_URI="mirror://sourceforge/pmt/${P}.tar.xz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=media-libs/libpng-1.4
	sys-libs/zlib"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

S=${WORKDIR}/${P}

src_compile() {
	emake CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dobin ${PN}
	dohtml ChangeLog.html
}
