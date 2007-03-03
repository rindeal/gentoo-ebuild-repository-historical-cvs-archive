# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RSS/XML-RSS-1.22.ebuild,v 1.4 2007/03/03 11:20:12 mcummings Exp $

inherit perl-module

IUSE=""
DESCRIPTION="a basic framework for creating and maintaining RSS files"
SRC_URI="mirror://cpan/authors/id/A/AB/ABH/${P}.tar.gz"
HOMEPAGE="http://perl-rss.sourceforge.net/"
SLOT="0"
LICENSE="Artistic"
#KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"

SRC_TEST="do"

DEPEND=">=dev-perl/Test-Manifest-0.9
	dev-perl/HTML-Parser
	dev-perl/DateTime-Format-Mail
	dev-perl/DateTime-Format-W3CDTF
	>=dev-perl/XML-Parser-2.30
	dev-lang/perl"

