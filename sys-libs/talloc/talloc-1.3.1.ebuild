# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/talloc/talloc-1.3.1.ebuild,v 1.3 2009/10/23 16:36:21 patrick Exp $

EAPI="2"

inherit confutils eutils autotools

DESCRIPTION="Samba talloc library"
HOMEPAGE="http://talloc.samba.org/"
SRC_URI="http://samba.org/ftp/talloc/${P}.tar.gz"
LICENSE="GPL-3"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc64 ~x86"

DEPEND="!net-fs/samba-libs[talloc]
	app-text/docbook-xml-dtd:4.2"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoconf -Ilibreplace
	sed -e 's:$(SHLD_FLAGS) :$(SHLD_FLAGS) $(LDFLAGS) :' -i Makefile.in
}

src_configure() {

	econf \
		--sysconfdir=/etc/samba \
		--localstatedir=/var \
		--enable-largefile \
	|| die "econf failed"

}

src_compile() {

	emake showflags || die "emake showflags failed"
	emake shared-build || die "emake shared-build failed"

}

src_install() {

	emake install DESTDIR="${D}" || die "emake install failed"
	dolib.a sharedbuild/lib/libtalloc.a
	dolib.so sharedbuild/lib/libtalloc.so

}
