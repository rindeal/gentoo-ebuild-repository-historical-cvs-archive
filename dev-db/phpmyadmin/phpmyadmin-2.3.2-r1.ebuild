# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phpmyadmin/phpmyadmin-2.3.2-r1.ebuild,v 1.1 2002/12/05 22:18:15 rphillips Exp $

MY_PN=phpMyAdmin

S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="Web-based administration for MySQL database in php"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}-php.tar.bz2"
HOMEPAGE="http://phpmyadmin.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
DEPEND=">=net-www/apache-1.3.24-r1 >=dev-db/mysql-3.23.38 >=dev-php/mod_php-4.1.2-r5"

# only known to work on x86... can people test on other platforms?
KEYWORDS="~x86"

APACHE_ROOT="`grep '^DocumentRoot' /etc/apache/conf/apache.conf | cut -d\  -f2`"
[ -z "${APACHE_ROOT}" ] && APACHE_ROOT="${APACHE_ROOT}"

src_compile() { :; }

src_install () {
	insinto ${APACHE_ROOT}/phpmyadmin
	doins *.{php,html}

	insinto ${APACHE_ROOT}/phpmyadmin/images
	doins images/*.{gif,png}

	insinto ${APACHE_ROOT}/phpmyadmin/scripts
	doins scripts/*.{php,sh}

	insinto ${APACHE_ROOT}/phpmyadmin/lang
	doins lang/*.{php,sh}

	insinto ${APACHE_ROOT}/phpmyadmin/libraries
	doins libraries/*.{php,js}

	insinto ${APACHE_ROOT}/phpmyadmin/libraries/auth
	doins libraries/auth/*.php

	insinto ${APACHE_ROOT}/phpmyadmin/libraries/fpdf
	doins libraries/fpdf/*.php

	insinto ${APACHE_ROOT}/phpmyadmin/libraries/fpdf/font
	doins libraries/fpdf/font/*.php

	insinto ${APACHE_ROOT}/phpmyadmin/libraries/xpath
	doins libraries/xpath/*.php

	dodoc ANNOUNCE.txt CREDITS ChangeLog TODO Documentation.{txt,html} \
		INSTALL LICENSE RELEASE-DATE*
}

pkg_postinst() {
	einfo
	einfo "Make sure you edit ${APACHE_ROOT}/phpmyadmin/config.inc.php"
	einfo
}
