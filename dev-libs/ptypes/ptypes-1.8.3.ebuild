# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ptypes/ptypes-1.8.3.ebuild,v 1.6 2005/10/18 15:44:31 george Exp $

DESCRIPTION="PTypes (C++ Portable Types Library) is a simple alternative to the STL that includes multithreading and networking."

HOMEPAGE="http://www.melikyan.com/ptypes/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND="virtual/libc"

src_compile() {
	make
}

src_install() {
	dolib lib/* || die
	insinto /usr/include
	doins include/* || die
	dohtml doc/* || die

	dodoc LICENSE
}
