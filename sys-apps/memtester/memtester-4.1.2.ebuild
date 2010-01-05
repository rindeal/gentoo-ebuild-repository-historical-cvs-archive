# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/memtester/memtester-4.1.2.ebuild,v 1.1 2010/01/05 03:54:36 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="userspace utility for testing the memory subsystem for faults"
HOMEPAGE="http://pyropus.ca/software/memtester/"
SRC_URI="http://pyropus.ca/software/memtester/${P}.tar.gz
	http://pyropus.ca/software/memtester/old-versions/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo "$(tc-getCC) ${CFLAGS} ${CPPFLAGS} -DPOSIX -c" > conf-cc
	echo "$(tc-getCC) ${CFLAGS} ${LDFLAGS}" > conf-ld
}

src_install() {
	dosbin memtester || die "dosbin failed"
	doman memtester.8
	dodoc BUGS CHANGELOG README README.tests
}
