# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Algorithm-Dependency/Algorithm-Dependency-1.101.ebuild,v 1.15 2007/01/14 21:59:38 mcummings Exp $

inherit perl-module

DESCRIPTION="Toolkit for implementing dependency systems"
HOMEPAGE="http://search.cpan.org/search?module=Algorithm-Dependency"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Test-ClassAPI
		dev-perl/Params-Util
		>=virtual/perl-File-Spec-0.82
		dev-lang/perl"
