# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpreludedb/libpreludedb-1.0.0.ebuild,v 1.1 2010/05/27 04:55:18 jer Exp $

inherit flag-o-matic eutils perl-module

DESCRIPTION="Prelude-IDS framework for easy access to the Prelude database"
HOMEPAGE="http://www.prelude-technologies.com"
SRC_URI="${HOMEPAGE}/download/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc mysql postgres perl python sqlite swig"

RDEPEND=">=dev-libs/libprelude-0.9.9
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )
	sqlite? ( =dev-db/sqlite-3* )"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )"

src_compile() {
	local myconf

	econf \
		$(use_with doc gtk-doc) \
		$(use_with mysql) \
		$(use_with postgres pgsql) \
		$(use_with sqlite sqlite3) \
		$(use_with perl) \
		$(use_with swig) \
		$(use_with python) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	use perl && fixlocalpod
}

pkg_postinst() {
	elog "For additional installation instructions go to"
	elog "https://trac.prelude-ids.org/wiki/InstallingLibpreludedb"
}
