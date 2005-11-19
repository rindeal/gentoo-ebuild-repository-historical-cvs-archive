# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-TimeZone/DateTime-TimeZone-0.37.ebuild,v 1.1 2005/11/19 08:28:33 mcummings Exp $

inherit perl-module

DESCRIPTION="Time zone object base class and factory"
HOMEPAGE="http://search.cpan.org/~drolsky/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/module-build
		>=dev-perl/Params-Validate-0.72
		>=dev-perl/Class-Singleton-1.03"

RDEPEND="dev-perl/DateTime"
