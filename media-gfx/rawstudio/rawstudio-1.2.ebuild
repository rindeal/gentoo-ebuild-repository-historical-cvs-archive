# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/rawstudio/rawstudio-1.2.ebuild,v 1.7 2011/03/12 10:34:50 radhermit Exp $

EAPI=2
inherit eutils

DESCRIPTION="a program to read and manipulate raw images from digital cameras."
HOMEPAGE="http://rawstudio.org"
SRC_URI="http://${PN}.org/files/release/${P}.tar.gz"

LICENSE="GPL-2 CCPL-Attribution-NoDerivs-2.5"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.4
	>=gnome-base/gconf-2
	media-gfx/exiv2
	=media-libs/lcms-1*
	media-libs/tiff
	sys-apps/dbus
	virtual/jpeg
	>=x11-libs/gtk+-2.8:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
}

src_configure() {
	econf --disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
