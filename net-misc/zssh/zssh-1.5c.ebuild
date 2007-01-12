# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zssh/zssh-1.5c.ebuild,v 1.1 2007/01/12 18:24:05 masterdriverz Exp $

inherit eutils

DESCRIPTION="An ssh wrapper enabling zmodem up/download in ssh"
HOMEPAGE="http://zssh.sourceforge.net/"
SRC_URI="mirror://sourceforge/zssh/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="readline nls"

DEPEND=""
RDEPEND="net-misc/openssh
	 net-dialup/lrzsz"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/zssh-1.5a-gentoo-include.diff
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable readline) || die 'configure failed'
	emake || die 'make failed'
}

src_install() {
	dobin zssh ztelnet
	doman zssh.1 ztelnet.1
	dodoc CHANGES FAQ README TODO
}
