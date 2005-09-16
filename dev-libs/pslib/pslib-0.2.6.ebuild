# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pslib/pslib-0.2.6.ebuild,v 1.4 2005/09/16 21:55:53 metalgod Exp $

IUSE="png jpeg"

DESCRIPTION="pslib is a C-library to create PostScript files on the fly."
HOMEPAGE="http://pslib.sourceforge.net/"
SRC_URI="mirror://sourceforge/pslib/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="dev-perl/XML-Parser
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )"
SLOT="0"

src_compile() {
	econf $(use_with png) $(use_with jpeg)  || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	emake DESTDIR=${D} install || die "Make install failed"
}
