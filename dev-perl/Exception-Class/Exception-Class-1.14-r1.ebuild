# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-Class/Exception-Class-1.14-r1.ebuild,v 1.6 2004/06/25 23:08:50 kugelfang Exp $

myconf='INSTALLDIRS=vendor'
inherit perl-module

DESCRIPTION="Exception::Class module for perl"
SRC_URI="http://www.cpan.org/modules/by-module/Exception/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Exception/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~ppc sparc alpha"

DEPEND="${DEPEND}
	>=dev-lang/perl-5.8.0-r12
	>=dev-perl/Class-Data-Inheritable-0.02
	>=dev-perl/Devel-StackTrace-1.01
	>=dev-perl/Test-Simple-0.47"

export OPTIMIZE="$CFLAGS"
