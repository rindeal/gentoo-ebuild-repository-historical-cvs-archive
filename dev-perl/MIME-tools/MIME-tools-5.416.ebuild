# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-tools/MIME-tools-5.416.ebuild,v 1.3 2005/05/25 14:11:25 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl module for parsing and creating MIME entities"
SRC_URI="mirror://cpan/authors/id/D/DS/DSKOLL/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~dskoll/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~ppc64"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
	>=dev-perl/IO-stringy-2.108
	>=perl-core/MIME-Base64-3.05
	dev-perl/libnet
	dev-perl/URI
	perl-core/Digest-MD5
	dev-perl/libwww-perl
	dev-perl/HTML-Tagset
	dev-perl/HTML-Parser
	dev-perl/MailTools"
