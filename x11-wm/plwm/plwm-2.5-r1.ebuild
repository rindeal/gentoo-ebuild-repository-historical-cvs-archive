# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/plwm/plwm-2.5-r1.ebuild,v 1.4 2007/07/01 21:34:29 armin76 Exp $

NEED_PYTHON="2.2"

inherit eutils python

DESCRIPTION="Python classes for, and an implementation of, a window manager."
HOMEPAGE="http://plwm.sourceforge.net/"
SRC_URI="mirror://sourceforge/plwm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ppc x86"
IUSE=""

DEPEND=">=dev-python/python-xlib-0.12"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-destdir.patch"
	epatch "${FILESDIR}/${P}-python2.5.patch"
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
	emake -C doc || die "emake -C doc failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	doinfo doc/*.info* || die "doinfo failed"
	dodoc README NEWS ONEWS examples/* || die "dodoc failed"
}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}
