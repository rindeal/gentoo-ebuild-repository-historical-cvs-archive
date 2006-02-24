# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zoo/zoo-2.10.ebuild,v 1.24 2006/02/24 04:33:23 smithj Exp $

inherit eutils

DESCRIPTION="Manipulate archives of files in compressed form."
HOMEPAGE="ftp://ftp.kiarchive.ru/pub/unix/arcers"
SRC_URI="ftp://ftp.kiarchive.ru/pub/unix/arcers/${P}pl1.tar.gz
	mirror://gentoo/${P}-gcc33-issues-fix.patch"

SLOT="0"
LICENSE="zoo"
IUSE=""
KEYWORDS="alpha amd64 ~hppa ppc ppc64 sparc x86"

S=${WORKDIR}

src_unpack() {
	unpack ${P}pl1.tar.gz
	epatch ${WORKDIR}/${P}-gcc33-issues-fix.patch
}

src_compile() {
	emake linux || die
}

src_install() {
	dobin zoo fiz
	doman zoo.1 fiz.1
}
