# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-F77/ExtUtils-F77-1.14-r1.ebuild,v 1.15 2006/08/05 03:32:17 mcummings Exp $

inherit perl-module

DESCRIPTION="Facilitate use of FORTRAN from Perl/XS code"
HOMEPAGE="http://search.cpan.org/~kgb/${P}/"
SRC_URI="mirror://cpan/authors/id/K/KG/KGB/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc sparc x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
