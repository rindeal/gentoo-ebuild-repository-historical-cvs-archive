# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdshconfig/libdshconfig-0.20.12.ebuild,v 1.7 2011/12/11 09:18:26 phajdan.jr Exp $

DESCRIPTION="Library for parsing dsh.style configuration files"
HOMEPAGE="http://www.netfort.gr.jp/~dancer/software/downloads/"
SRC_URI="http://www.netfort.gr.jp/~dancer/software/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~m68k-mint"
IUSE=""

DEPEND=""
RDEPEND="virtual/ssh"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog
}
