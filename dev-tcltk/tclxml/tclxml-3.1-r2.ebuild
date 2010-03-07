# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclxml/tclxml-3.1-r2.ebuild,v 1.1 2010/03/07 08:52:17 jlec Exp $

inherit autotools eutils

DESCRIPTION="Pure Tcl implementation of an XML parser."
HOMEPAGE="http://tclxml.sourceforge.net/"
SRC_URI="mirror://sourceforge/tclxml/${P}.tar.gz"

IUSE="debug expat threads xml"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

DEPEND=">=dev-lang/tcl-8.2
	>=dev-tcltk/tcllib-1.2
	xml? ( >=dev-libs/libxml2-2.6.9 )
	expat? (
		dev-libs/expat
		virtual/libiconv )
	!dev-tcltk/tclxml-expat"
#	test? ( dev-tcltk/tclparser )
RESTRICT="test"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-3_configure.patch
	epatch "${FILESDIR}"/${PN}-3_include_path.patch
	epatch "${FILESDIR}"/${P}-test.patch

	eautoreconf
}

src_compile() {
	econf ${myconf} \
      --with-tclinclude="${EPREFIX}"/usr/include \
      --with-tcl="${EPREFIX}"/usr/$(get_libdir) \
		$(use_enable amd64 64bit) \
		$(use_enable debug symbols) \
		$(use_enable threads)

	emake || die

	if use xml ; then
		cd "${S}"/libxml2
		econf ${myconf} --with-Tclxml=.. || die
		emake || die
	fi
	if use expat ; then
		cd "${S}"/expat
		econf ${myconf} --with-Tclxml=.. || die
		emake || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use xml ; then
		cd "${S}"/libxml2
		emake DESTDIR="${D}" install || die
	fi
	if use expat ; then
		cd "${S}"/expat
		emake DESTDIR="${D}" install || die
	fi

	cd "${S}"
	dodoc ANNOUNCE ChangeLog README RELNOTES || die
	dohtml doc/*.html || die
}
