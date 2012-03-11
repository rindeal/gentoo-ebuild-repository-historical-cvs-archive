# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/spread/spread-4.0.0.ebuild,v 1.5 2012/03/11 23:56:11 kumba Exp $

EAPI=4
inherit eutils

MY_PN="spread-src"

DESCRIPTION="Distributed network messaging system"
HOMEPAGE="http://www.spread.org"
SRC_URI="mirror://gentoo/${MY_PN}-${PV}.tar.gz"

LICENSE="Spread-1.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup() {
	enewuser spread
	enewgroup spread
}

src_prepare() {
	# don't strip binaries
	sed -i -e 's/0755 -s/0755/g' daemon/Makefile.in examples/Makefile.in
}

src_install() {
	emake DESTDIR="${D}" docdir="/usr/share/doc/${PF}" install
	newinitd "${FILESDIR}"/spread.init.d spread
	dodir /var/run/spread
}
