# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libxspf/libxspf-1.2.0.ebuild,v 1.11 2012/07/30 10:27:14 ssuominen Exp $

EAPI=4
inherit eutils

DESCRIPTION="Playlist handling library"
HOMEPAGE="http://libspiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/libspiff/${P}.tar.bz2"

LICENSE="BSD LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc static-libs test"

RDEPEND=">=dev-libs/expat-2
	>=dev-libs/uriparser-0.7.5"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? (
		>=app-doc/doxygen-1.5.8
		media-gfx/graphviz
		x11-libs/qt-assistant:4
		)
	test? ( >=dev-util/cpptest-1.1 )"

DOCS="AUTHORS ChangeLog NEWS README THANKS"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-gcc47.patch
}

src_configure() {
	export XDG_CONFIG_HOME="${T}" #398881#c2

	econf \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable static-libs static) \
		$(use_enable test) \
		$(use_enable doc)
}

src_install() {
	default
	prune_libtool_files
}
