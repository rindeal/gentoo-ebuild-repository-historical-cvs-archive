# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Memory-Cycle/Test-Memory-Cycle-1.02.ebuild,v 1.3 2005/12/14 07:19:47 cardoe Exp $

inherit perl-module

DESCRIPTION="Check for memory leaks and circular memory references"
HOMEPAGE="http://search.cpan.org/~petdance/${P}/"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Devel-Cycle
	|| ( 	>=perl-core/Test-Simple-0.62
		( <perl-core/Test-Simple-0.62 dev-perl/Test-Builder-Tester ) )"
