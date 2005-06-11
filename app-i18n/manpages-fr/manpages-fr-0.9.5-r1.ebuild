# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/manpages-fr/manpages-fr-0.9.5-r1.ebuild,v 1.1 2005/06/11 16:26:29 chainsaw Exp $

MY_P=${PN/pages/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A somewhat comprehensive collection of french Linux man pages"
SRC_URI="http://fr.tldp.org/${MY_P}-${PV}.tar.gz"
HOMEPAGE="http://fr.tldp.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

DEPEND="app-arch/gzip"
RDEPEND="sys-apps/man"

src_unpack() {
	unpack ${A}
	# Don't trample on lilo's files, closes bug #91314
	rm ${S}/man8/lilo.8
	rm ${S}/man5/lilo.conf.5
}

src_compile() {
	for x in man?
	do
		gzip ${S}/${x}/* || die
	done
}

src_install() {
	for x in man?
	do
		dodir /usr/share/man/fr/${x}
		install -m 644 ${S}/${x}/* ${D}/usr/share/man/fr/${x}
	done
}
