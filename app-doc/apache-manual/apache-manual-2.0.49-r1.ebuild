# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/apache-manual/apache-manual-2.0.49-r1.ebuild,v 1.11 2004/05/06 22:16:03 avenj Exp $

DESCRIPTION="Configures the apache manual for local viewing."
HOMEPAGE="http://www.apache.org"
SRC_URI="http://www.apache.org/dist/httpd/httpd-${PV}.tar.gz"
KEYWORDS="x86 ~ppc hppa ~mips sparc amd64 ~ia64 alpha"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND="=net-www/apache-2*
	>=sys-apps/sed-4"
RDEPEND=""

IUSE=""

src_compile() {
	einfo "Nothing to do."
}

src_install() {
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/00_apache_manual.conf
	sed -i -e "s:2.0.49:${PV}:" ${D}/etc/apache2/conf/modules.d/00_apache_manual.conf
}
