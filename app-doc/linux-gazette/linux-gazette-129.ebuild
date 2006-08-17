# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/linux-gazette/linux-gazette-129.ebuild,v 1.1 2006/08/17 23:14:20 wormo Exp $

DESCRIPTION="Sharing ideas and discoveries and Making Linux just a little more fun"
HOMEPAGE="http://linuxgazette.net/"
SRC_URI="http://linuxgazette.net/ftpfiles/lg-${PV}.tar.gz"

LICENSE="OPL"
SLOT="${PV}"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=">=app-doc/linux-gazette-base-${PV}"

S=${WORKDIR}/lg

src_install() {
	dodir /usr/share/doc
	mv "${S}" "${D}"/usr/share/doc/${PN} || die
}
