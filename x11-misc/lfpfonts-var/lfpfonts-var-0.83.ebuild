# Copyrigth 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Aron Griffis <agriffis@gentoo.org>
# Maintainer: Aron Griffis
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lfpfonts-var/lfpfonts-var-0.83.ebuild,v 1.2 2002/07/08 21:31:07 aliz Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Linux Font Project variable-width fonts"
SRC_URI="http://dreamer.nitro.dk/linux/lfp/${P}.tar.bz2"
HOMEPAGE="http://dreamer.nitro.dk/linux/lfp/"
LICENSE="Public Domain"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11"

src_install() {
	dodoc doc/*
	cd lfp-var
	insinto /usr/X11R6/lib/X11/fonts/lfp-var
	insopts -m0644
	doins *
}
