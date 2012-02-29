# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/cronutils/cronutils-1.1.ebuild,v 1.2 2012/02/29 15:29:32 ago Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Utilities to assist running batch processing jobs"
HOMEPAGE="http://code.google.com/p/cronutils/"
SRC_URI="http://cronutils.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr install
}
