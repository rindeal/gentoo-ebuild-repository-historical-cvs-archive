# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugzilla/bugzilla-2.22.1.ebuild,v 1.3 2006/12/22 11:45:11 rl03 Exp $

inherit webapp

DESCRIPTION="Bugzilla is the Bug-Tracking System from the Mozilla project"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/webtools/${P}.tar.gz"
HOMEPAGE="http://www.bugzilla.org"

LICENSE="MPL-1.1 NPL-1.1"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="apache2 extras graphviz mysql postgres"

RDEPEND="
	>=dev-lang/perl-5.6.1
	postgres? ( >=dev-db/postgresql-7.3 >=dev-perl/DBD-Pg-1.45 )
	mysql? ( >=virtual/mysql-4.0 >=dev-perl/DBD-mysql-3.0007 )
	apache2? ( >=net-www/apache-2.0 )
	!apache2? ( =net-www/apache-1* )
	graphviz? ( media-gfx/graphviz )
	>=dev-perl/AppConfig-1.52
	>=virtual/perl-CGI-2.93
	>=dev-perl/TimeDate-1.16
	>=dev-perl/DBI-1.38
	>=virtual/perl-File-Spec-0.84
	virtual/perl-File-Temp
	>=dev-perl/Template-Toolkit-2.13
	>=dev-perl/Text-Tabs+Wrap-2001.0131
	>=dev-perl/MailTools-1.67
	>=virtual/perl-MIME-Base64-3.01
	dev-perl/MIME-tools
	virtual/perl-Storable

	extras? (
	>=dev-perl/Chart-2.3
	>=dev-perl/GD-1.20
	dev-perl/GDGraph
	dev-perl/GDTextUtil
	dev-perl/perl-ldap
	>=dev-perl/PatchReader-0.9.4
	dev-util/patchutils
	dev-perl/XML-Twig )
"
# dev-util/patchutils needed for interdiff

src_unpack() {
	unpack ${A}
	cd ${S}
	# remove CVS directories
	find . -type d -name 'CVS' -print | xargs rm -rf
}

src_install () {
	webapp_src_preinst

	cp -r ${S}/* ${D}/${MY_HTDOCSDIR} || die
	for file in `find -type d -printf "%p/* "`; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	cp ${FILESDIR}/2.22/apache.htaccess ${D}/${MY_HTDOCSDIR}/.htaccess

	local FILE="bugzilla.cron.daily bugzilla.cron.tab"
	cd ${FILESDIR}/2.22
	cp ${FILE} ${D}/${MY_HTDOCSDIR}

	webapp_hook_script ${FILESDIR}/2.22/reconfig
	webapp_postinst_txt en ${FILESDIR}/2.22/postinstall-en.txt
	webapp_src_install
}
