# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pdumpfs/pdumpfs-0.8.ebuild,v 1.6 2004/06/25 23:53:36 vapier Exp $

DESCRIPTION="a daily backup system similar to Plan9's dumpfs"
HOMEPAGE="http://www.namazu.org/~satoru/pdumpfs/"
SRC_URI="http://www.namazu.org/~satoru/pdumpfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="cjk"

DEPEND="virtual/libc"
RDEPEND="virtual/ruby"

src_install() {
	dobin pdumpfs || die

	doman man/man8/pdumpfs.8

	if use cjk; then
		insinto /usr/share/man/ja/man8
		doins man/ja/man8/pdumpfs.8
	fi

	dodoc ChangeLog
	dohtml *.html
}
