# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/jfsutils/jfsutils-1.1.1-r1.ebuild,v 1.6 2005/04/01 17:22:46 agriffis Exp $

inherit eutils

DESCRIPTION="IBM's Journaling Filesystem (JFS) Utilities"
HOMEPAGE="http://www-124.ibm.com/developerworks/oss/jfs/index.html"
SRC_URI="http://www10.software.ibm.com/developer/opensource/jfs/project/pub/${P}.tar.gz
	mirror://gentoo/${P}-errno.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc amd64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	# Patch to allow compilation with glibc-2.3.2
	# (the infamous errno issue)
	epatch ${WORKDIR}/${P}-errno.diff
}


src_compile() {
	econf \
		--sbindir=/sbin || die "econf failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	rm -f ${D}/sbin/mkfs.jfs fsck.jfs
	dosym /sbin/jfs_mkfs /sbin/mkfs.jfs
	dosym /sbin/jfs_fsck /sbin/fsck.jfs

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
