# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Schedule-At/Schedule-At-1.06.ebuild,v 1.7 2006/10/15 17:24:55 kloeri Exp $

inherit perl-module

DESCRIPTION="OS independent interface to the Unix 'at' command"
SRC_URI="mirror://cpan/authors/id/J/JO/JOSERODR/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/Schedule-At/"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ia64 sparc ~x86"
IUSE=""

#SRC_TEST="do"

DEPEND="sys-process/at
	dev-lang/perl"
