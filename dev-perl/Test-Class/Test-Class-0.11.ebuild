# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Class/Test-Class-0.11.ebuild,v 1.7 2005/12/06 12:52:18 mcummings Exp $

inherit perl-module

DESCRIPTION="Easily create test classes in an xUnit style."
HOMEPAGE="http://search.cpan.org/~adie/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AD/ADIE/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND=">=perl-core/Storable-2
		dev-perl/module-build
		||( ( >=perl-core/Test-Simple-0.62 )
		( <perl-core/Test-Simple-0.62 dev-perl/Test-Builder-Tester )
		)
		dev-perl/Test-Differences
		dev-perl/Test-Exception
		dev-perl/Test-SimpleUnit
		dev-perl/Pod-Coverage"
