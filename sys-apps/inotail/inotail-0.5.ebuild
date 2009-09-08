# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/inotail/inotail-0.5.ebuild,v 1.4 2009/09/08 18:09:17 ikelos Exp $

inherit linux-info

DESCRIPTION="tail replacement using inotify"
HOMEPAGE="http://distanz.ch/inotail/"
SRC_URI="http://distanz.ch/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

CONFIG_CHECK="~INOTIFY"

src_install() {
	make prefix="${D}/usr" install || die "install failed"
	dodoc changelog README
}
