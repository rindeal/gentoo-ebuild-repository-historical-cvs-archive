# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdplay/cdplay-0.8.ebuild,v 1.6 2002/11/14 21:58:48 wwoods Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Console CD Player"
SRC_URI="http://www.x-paste.de/files/${P}.tar.gz"
HOMEPAGE="http://www.x-paste.de/projects/index.php"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~alpha"

src_compile () {
	make || die
}

src_install () {
	into /usr
	dobin cdplay

	dodoc CREDITS README
}
