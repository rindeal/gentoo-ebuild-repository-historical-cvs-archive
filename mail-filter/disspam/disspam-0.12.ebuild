# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/disspam/disspam-0.12.ebuild,v 1.3 2004/07/14 16:41:57 agriffis Exp $

S=${WORKDIR}/disspam
DESCRIPTION="A Perl script that removes spam from POP3 mailboxes based on RBLs."
HOMEPAGE="http://www.topfx.com/"
SRC_URI="http://www.topfx.com/dist/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~ppc sparc ~hppa ~alpha ~mips"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1
	>=dev-perl/libnet-1.11
	>=sys-apps/sed-4
	>=dev-perl/Net-DNS-0.12"

src_install() {
	#This doesnt look neat but makes it work
	sed -i \
		-e 's/\/usr\/local\/bin\/perl/\/usr\/bin\/perl/' disspam.pl || \
			die "sed disspam.pl failed"
	dobin disspam.pl
	dodoc changes.txt configuration.txt readme.txt sample.conf
}
