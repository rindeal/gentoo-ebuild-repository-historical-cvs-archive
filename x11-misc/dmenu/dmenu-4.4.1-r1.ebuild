# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dmenu/dmenu-4.4.1-r1.ebuild,v 1.3 2012/02/16 06:50:30 jer Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="a generic, highly customizable, and efficient menu for the X Window System"
HOMEPAGE="http://tools.suckless.org/dmenu/"
SRC_URI="http://dl.suckless.org/tools/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="xinerama"

DEPEND="x11-libs/libX11
	xinerama? ( x11-libs/libXinerama )"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e "s/CFLAGS   = -ansi -pedantic -Wall -Os/CFLAGS  += -ansi -pedantic -Wall/" \
		-e "s/LDFLAGS  = -s/LDFLAGS  +=/" \
		-e "s/XINERAMALIBS  =/XINERAMALIBS  ?=/" \
		-e "s/XINERAMAFLAGS =/XINERAMAFLAGS ?=/" \
		config.mk || die
	sed -i -e 's|lsx|dmenu_&|g' dmenu_run lsx.1 lsx.c || die
}

src_compile() {
	if use xinerama; then
		emake CC=$(tc-getCC)
	else
		emake CC=$(tc-getCC) XINERAMAFLAGS="" XINERAMALIBS=""
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
	mv "${D}"/usr/bin/{,dmenu_}lsx || die
	mv "${D}"/usr/share/man/man1/{,dmenu_}lsx.1 || die
}
