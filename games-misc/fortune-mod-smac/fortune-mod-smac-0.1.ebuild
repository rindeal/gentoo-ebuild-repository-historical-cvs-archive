# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-smac/fortune-mod-smac-0.1.ebuild,v 1.5 2003/12/01 21:12:34 vapier Exp $

DESCRIPTION="Quotes from the Alpha Centauri: Alien Crossfire tech tree"
HOMEPAGE="http://homepages.ihug.com.au/~alana/"
SRC_URI="http://homepages.ihug.com.au/~alana/files/fortune-mod-smac/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"

RDEPEND="games-misc/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins smac smac.dat
}
