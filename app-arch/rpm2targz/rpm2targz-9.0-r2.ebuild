# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm2targz/rpm2targz-9.0-r2.ebuild,v 1.4 2004/04/13 22:54:53 kumba Exp $

inherit eutils

DESCRIPTION="Convert a .rpm file to a .tar.gz archive"
HOMEPAGE="http://www.slackware.com/config/packages.php"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="ia64 x86 sparc ppc alpha hppa amd64 mips"

# NOTE: rpm2targz autodetects rpm2cpio at runtime, and uses it if available,
#       so we don't explicitly set it as a dependency.
DEPEND="virtual/glibc
	app-arch/cpio
	sys-apps/file"

RDEPEND="$DEPEND sys-apps/util-linux sys-apps/which"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	# makes rpm2targz extract in current dir
	epatch ${FILESDIR}/${P}-gentoo.patch
	# adds bzip2 detection (#23249)
	epatch ${FILESDIR}/${P}-bzip2.patch
	# adds bzip2 decompression to rpm2targz (#31164)
	epatch ${FILESDIR}/${P}-bzip2_rpm2targz.patch
}

src_compile() {
	${CC:-gcc} ${CFLAGS} -o rpmoffset rpmoffset.c || die
}

src_install() {
	dobin rpmoffset rpm2targz
	dodoc rpm2targz.README
}
