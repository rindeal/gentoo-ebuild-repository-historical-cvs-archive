# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/twiki/twiki-20030201.ebuild,v 1.3 2004/01/27 23:18:40 mholzer Exp $ 

inherit webapp-apache

DESCRIPTION="A Web Based Collaboration Platform"
HOMEPAGE="http://twiki.org/"
SRC_URI="http://twiki.org/swd/TWiki${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"

RDEPEND="virtual/php
	media-gfx/graphviz
	dev-db/mysql"

IUSE="apache2"

webapp-detect || NO_WEBSERVER=1

pkg_setup() {
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing for ${WEBAPP_SERVER}"
}

src_unpack() {
	mkdir ${P}
	cd ${S}
	unpack ${A}

	sed -i -e 's:\/home\/httpd:\/var\/www:g' lib/TWiki.cfg
#	sed -i -e 's:urlpath\/to:var\/www\/localhost\/htdocs:g' \
#		bin/.htaccess.txt
#	echo "Options ExecCGI" >> bin/.htaccess.txt
}


src_install() {
	local destdir=/var/www/twiki

	dodir ${destdir}
	cp -r . ${D}${destdir}

	if [ "`use apache2`" ]; then
		dodir /etc/apache2/conf/modules.d
		insinto /etc/apache2/conf/modules.d
		newins ${FILESDIR}/twiki.conf 97_twiki.conf
	else
		dodir /etc/apache/conf/addon-modules
		insinto /etc/apache/conf/addon-modules
		doins ${FILESDIR}/twiki.conf
	fi

	dodoc readme.txt license.txt
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${destdir}
	chmod 0775 -R ${destdir}/pub ${destdir}/data
	chown nobody -R ${destdir}/pub ${destdir}/data
	#find ${D}/${HTTPD_ROOT}/${PN}/templates -type d -exec chmod 0440 {} \;
#	chmod 0444 -R ${PN}/templates
}

pkg_postinst() {
	einfo "now go to your ${HTTPD_ROOT}/{PN},"
	einfo "copy bin/.htaccess.txt to bin/.htaccess"
	einfo "and be sure to read"
	einfo "http://localhost/twiki/bin/view/TWiki/TWikiDocumentation#TWiki_Installation_Guide"
}
