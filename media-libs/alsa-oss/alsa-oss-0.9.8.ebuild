# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-oss/alsa-oss-0.9.8.ebuild,v 1.2 2003/11/16 18:20:43 brad_mssw Exp $

DESCRIPTION="Advanced Linux Sound Architecture OSS compatibility layer."
HOMEPAGE="http://www.alsa-project.org/"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=media-libs/alsa-lib-0.9.8"

SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc amd64"

SRC_URI="mirror://alsaproject/oss-lib/${P}.tar.bz2"
RESTRICT="nomirror"
S=${WORKDIR}/${P}

src_compile() {
	econf || die "./configure failed"
	emake || die "Parallel Make Failed"
}

src_install() {
	einstall || die
	dodoc COPYING
}
