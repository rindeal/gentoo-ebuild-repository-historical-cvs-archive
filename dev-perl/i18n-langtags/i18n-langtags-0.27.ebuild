# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/i18n-langtags/i18n-langtags-0.27.ebuild,v 1.5 2002/08/01 22:49:16 cselkirk Exp $

inherit perl-module

MY_P=I18N-LangTags-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="RFC3066 language tag handling for Perl"
SRC_URI="http://www.cpan.org/modules/by-module/I18N/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/I18N/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
