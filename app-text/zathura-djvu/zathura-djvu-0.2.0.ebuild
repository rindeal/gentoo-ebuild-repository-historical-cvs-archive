# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura-djvu/zathura-djvu-0.2.0.ebuild,v 1.2 2012/07/10 20:00:35 ago Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="DjVu plug-in for zathura"
HOMEPAGE="http://pwmt.org/projects/zathura/"
SRC_URI="http://pwmt.org/projects/zathura/plugins/download/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND=">=app-text/djvu-3.5.24-r1
	>=app-text/zathura-0.2.0
	>=dev-libs/girara-0.1.3:2
	>=dev-libs/glib-2
	x11-libs/cairo"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	myzathuraconf=(
		CC="$(tc-getCC)"
		LD="$(tc-getLD)"
		VERBOSE=1
		DESTDIR="${D}"
		)
}

src_compile() {
	emake "${myzathuraconf[@]}"
}

src_install() {
	emake "${myzathuraconf[@]}" install
	dodoc AUTHORS
}
