# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/edictionary/edictionary-1.2.ebuild,v 1.5 2005/01/01 12:51:28 eradicator Exp $

MY_PN="edict"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Command line dictionary and thesaurus"
HOMEPAGE="http://edictionary.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

RDEPEND=""
DEPEND="dev-lang/perl"

S="${WORKDIR}/${MY_PN}"

src_install() {
	make prefix=${D}/usr/bin install || die "make failed"
	dodoc README
}
