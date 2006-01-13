# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Tests/Pod-Tests-0.18.ebuild,v 1.6 2006/01/13 22:12:18 mcummings Exp $

inherit perl-module

DESCRIPTION="Extracts embedded tests and code examples from POD"
HOMEPAGE="http://search.cpan.org/search?module=${PN}"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=perl-core/Test-Harness-1.22"
