# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmerlin/kmerlin-1.0-r1.ebuild,v 1.6 2002/10/04 06:04:40 vapier Exp $

inherit kde-base || die

need-kde 3
# despite being a kde3 app, its configure script was generated by autoconf 2.13 so:
need-autoconf 2.1

DESCRIPTION="KDE MSN Messenger"
SRC_URI="mirror://sourceforge/kmerlin/${P}.tar.gz"
HOMEPAGE="http://kmerlin.olsd.de"


LICENSE="GPL-2"
KEYWORDS="x86"
