# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libmrss/libmrss-0.19.2.ebuild,v 1.2 2011/09/26 21:56:36 radhermit Exp $

EAPI="2"

DESCRIPTION="A C-library for parsing and writing RSS 0.91/0.92/1.0/2.0 files or streams"
HOMEPAGE="http://www.autistici.org/bakunin/libmrss/doc/"
SRC_URI="http://www.autistici.org/bakunin/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples php"

RDEPEND=">=net-libs/libnxml-0.18.0
	net-misc/curl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

# TODO: php-bindings

src_compile() {
	emake || die "make failed"

	if use doc; then
		ebegin "Creating documentation"
		doxygen doxy.conf || die "generating docs failed"
		eend 0
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README

	if use doc; then
		dohtml doc/html/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/test
		doins test/*.c
	fi
}
