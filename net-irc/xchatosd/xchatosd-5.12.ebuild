# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchatosd/xchatosd-5.12.ebuild,v 1.8 2005/02/17 02:54:14 swegener Exp $

inherit eutils

DESCRIPTION="On-Screen Display for XChat"
HOMEPAGE="http://sourceforge.net/projects/xchatosd/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="iconv"

RDEPEND=">=x11-libs/xosd-2.2.5
	>=net-irc/xchat-2.0.9"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-return-values.patch

	# We have our own include file in /usr/include/xchat
	einfo "Updating xchat-plugin.h from /usr/include/xchat/xchat-plugin.h"
	cp -f ${ROOT}/usr/include/xchat/xchat-plugin.h xchat-plugin.h
}

src_compile() {
	use iconv || sed -i -e "s/#define ICONV_LIB//" xchatosd.h

	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/xchat/plugins
	doexe xchatosd.so || die "doexe failed"
	dodoc ChangeLog README || die "dodoc failed"
}
