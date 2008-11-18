# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-WikiFormat/Text-WikiFormat-0.79.ebuild,v 1.6 2008/11/18 15:40:09 tove Exp $

inherit perl-module

DESCRIPTION="Translate Wiki formatted text into other formats"
SRC_URI="mirror://cpan/authors/id/C/CH/CHROMATIC/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~chromatic/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 ~ppc sparc x86"

DEPEND="dev-perl/URI
	virtual/perl-Scalar-List-Utils
	>=virtual/perl-Module-Build-0.28
	dev-lang/perl"
IUSE=""

SRC_TEST="do"
