# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-DBI/Template-DBI-2.64.ebuild,v 1.4 2006/08/27 21:13:31 weeve Exp $

inherit perl-module

DESCRIPTION="DBI plugin for the Template Toolkit"
SRC_URI="mirror://cpan/modules/by-module/Template/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/${P}/"
SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl
		dev-perl/DBI
		>=dev-perl/Template-Toolkit-2.15-r1"
RDEPEND="${DEPEND}"

src_compile() {
		echo "n" | perl-module_src_compile
}
