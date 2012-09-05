# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libzdb/libzdb-2.10.3.ebuild,v 1.2 2012/09/05 19:27:25 lordvan Exp $

EAPI="4"

inherit eutils toolchain-funcs autotools-utils

DESCRIPTION="A thread safe high level multi-database connection pool library"
HOMEPAGE="http://www.tildeslash.com/libzdb/"
SRC_URI="http://www.tildeslash.com/${PN}/dist/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug doc mysql postgres +sqlite +sqliteunlock ssl static-libs"
REQUIRED_USE=" || ( postgres mysql sqlite )"

RDEPEND="mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	sqlite? ( >=dev-db/sqlite-3 )
	sqliteunlock? ( >=dev-db/sqlite-3.6.12[unlock-notify] )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

src_prepare() {
	sed -i -e "s|&& ./pool||g" test/Makefile.in || die
	if ( use sqlite); then
		epatch "$FILESDIR/sqlite_configure.patch"
	fi
	eautoreconf
}

src_configure() {
	## TODO: check what --enable-optimized actually does
	## TODO: find someone with oracle db to add oci8 support
	myconf=""
	if  [[ $(gcc-version) < 4.1 ]];then
		myconf="${myconf} --disable-protected"
	else
		myconf="${myconf} --enable-protected"
	fi

	if ( use sqlite ); then
		myconf="${myconf} --with-sqlite=${EPREFIX}/usr/"
		if has_version 'dev-db/sqlite[unlock-notify]'; then
			myconf="${myconf} --enable-sqliteunlock"
		fi
	else
		myconf="${myconf} --without-sqlite"
	fi

	if use mysql; then
		myconf="${myconf} --with-mysql=${EPREFIX}/usr/bin/mysql_config"
	else
		myconf="${myconf} --without-mysql"
	fi

	if use postgres; then
		myconf="${myconf} --with-postgresql=${EPREFIX}/usr/bin/pg_config"
	else
		myconf="${myconf} --without-postgresql"
	fi

	econf \
		$(use_enable debug profiling) \
		$(use_enable static-libs static) \
		$(use_enable ssl openssl) \
		--without-oci \
		${myconf}
}

src_compile() {
	default_src_compile
	if use doc; then
		emake doc
	fi
}

src_install() {
	emake DESTDIR="${D}" install

	# the --disable-static flag only skips .a
	use static-libs || rm -f "${D}"/usr/lib*/libzdb.la

	dodoc AUTHORS CHANGES README
	if use doc;then
		dohtml -r "${S}/doc/api-docs"/*
	fi
}

src_test() {
	emake verify
}
