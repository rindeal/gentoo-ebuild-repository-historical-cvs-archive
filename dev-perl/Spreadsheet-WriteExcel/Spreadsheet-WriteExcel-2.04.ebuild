# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Spreadsheet-WriteExcel/Spreadsheet-WriteExcel-2.04.ebuild,v 1.7 2005/04/29 13:19:36 mcummings Exp $

inherit perl-module

DESCRIPTION="Write cross-platform Excel binary file."
SRC_URI="mirror://cpan/authors/id/J/JM/JMCNAMARA/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/J/JM/JMCNAMARA/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ppc"

DEPEND="dev-perl/File-Temp
	dev-perl/Parse-RecDescent"
IUSE=""
