# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libspectrum/libspectrum-0.2.1.ebuild,v 1.4 2005/01/01 14:14:23 eradicator Exp $

DESCRIPTION="Spectrum emulation library"
HOMEPAGE="http://fuse-emulator.sourceforge.net/libspectrum.php"
SRC_URI="mirror://sourceforge/fuse-emulator/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ~ppc"

DEPEND="=dev-libs/glib-1*
	>=dev-libs/libgcrypt-1.1.91
	dev-lang/perl"

src_compile() {
	econf --with-glib || die
	emake -j1 || die "libspectrum make failed!"
}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog README THANKS doc/*.txt *.txt
}
