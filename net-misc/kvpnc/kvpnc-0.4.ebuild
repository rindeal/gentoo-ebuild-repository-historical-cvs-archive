# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kvpnc/kvpnc-0.4.ebuild,v 1.2 2004/09/03 01:06:25 dholm Exp $

inherit kde-base
need-kde 3.2

DESCRIPTION="kvpnc - a KDE-VPN connection utility."
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"
HOMEPAGE="http://home.gna.org/${PN}/"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""
SLOT="0"
DEPEND=">=net-misc/vpnc-0.2"
