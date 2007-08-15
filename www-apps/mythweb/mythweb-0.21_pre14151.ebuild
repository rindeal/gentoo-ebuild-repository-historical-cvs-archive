# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mythweb/mythweb-0.21_pre14151.ebuild,v 1.3 2007/08/15 13:43:17 cardoe Exp $

inherit mythtv webapp depend.php subversion

DESCRIPTION="PHP scripts intended to manage MythTV from a web browser."
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="dev-perl/DBI
		dev-perl/DBD-mysql"

need_php5_httpd

pkg_setup() {
	webapp_pkg_setup
	require_php_with_use session mysql pcre posix
}

src_unpack() {
	subversion_src_unpack
}

src_compile() {
	:
}

src_install() {
	webapp_src_preinst

	dodoc README TODO

	dodir ${MY_HTDOCSDIR}/data

	cp -R ${S}/[[:lower:]]* ${D}${MY_HTDOCSDIR}
	cp ${S}/mythweb.conf.apache ${MY_SERVERCONFIGDIR}/
	cp ${S}/mythweb.conf.lighttpd ${MY_SERVERCONFIGDIR}/

	webapp_serverowned ${MY_HTDOCSDIR}/data

	# should these be uncommented?
	#webapp_configfile ${MY_SERVERCONFIGDIR}/mythweb.conf.apache
	#webapp_configfile ${MY_SERVERCONFIGDIR}/mythweb.conf.lighttpd

	webapp_postinst_txt en ${FILESDIR}/postinstall-en-0.21.txt

	webapp_src_install
}
