# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-0.9.6.ebuild,v 1.6 2002/10/04 06:04:44 vapier Exp $

inherit kde-base || die

S="${WORKDIR}/${P}"
need-kde 3

DESCRIPTION="KDE MSN Messenger"
SRC_URI="mirror://sourceforge/kmess/${P}.tar.gz"
HOMEPAGE="http://kmess.sourceforge.net"


LICENSE="GPL-2"
KEYWORDS="x86"
