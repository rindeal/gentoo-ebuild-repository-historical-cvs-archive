# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aria/aria-1.0.0.ebuild,v 1.12 2006/06/24 15:28:22 betelgeuse Exp $

inherit eutils

IUSE="nls"

DESCRIPTION="Aria is a download manager with a GTK+ GUI, it downloads files from the Internet via HTTP/HTTPS or FTP."
HOMEPAGE="http://aria.rednoah.com"
SRC_URI="http://aria.rednoah.com/storage/sources/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc sparc x86"

DEPEND="nls? ( sys-devel/gettext dev-util/intltool )
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	dev-libs/openssl"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-xgettext-gentoo.diff
	epatch "${FILESDIR}"/${P}-savefiles-gentoo.diff
	epatch "${FILESDIR}"/${P}-bigendian.diff
	epatch "${FILESDIR}"/${P}-gcc41.patch
}

src_compile() {
	econf $(use_enable nls) || die "econf failed"

	# This fixes an infinite loop bug
	touch Makefile

	emake || die "emake failed"
}

src_install() {
	einstall || die

	dodoc AUTHORS README* NEWS ChangeLog TODO COPYING
	touch "${D}"/usr/share/aria/ftp_proxy.aria
	touch "${D}"/usr/share/aria/gui.aria
	touch "${D}"/usr/share/aria/history.aria
	touch "${D}"/usr/share/aria/http_proxy.aria
}
