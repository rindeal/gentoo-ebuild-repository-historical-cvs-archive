# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Readonly/Readonly-1.03.ebuild,v 1.6 2009/03/01 14:52:40 nixnut Exp $

inherit perl-module

DESCRIPTION="Facility for creating read-only scalars, arrays, hashes"
SRC_URI="mirror://cpan/authors/id/R/RO/ROODE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/Readonly/Readonly.pm"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
