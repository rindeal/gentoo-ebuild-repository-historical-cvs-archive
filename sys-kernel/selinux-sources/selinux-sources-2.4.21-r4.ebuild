# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/selinux-sources/selinux-sources-2.4.21-r4.ebuild,v 1.2 2003/11/20 07:43:38 lostlogic Exp $

IUSE=""

ETYPE="sources"
inherit kernel
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-${PN/-*/}"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}
DESCRIPTION="LSM patched kernel with SELinux"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://gentoo/patches-${KV}.tar.bz2"

HOMEPAGE="http://www.kernel.org/ http://www.nsa.gov/selinux"
KEYWORDS="x86 -ppc -alpha -sparc -mips -hppa -arm -amd64 -ia64"
SLOT="${KV}"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die

	cd ${KV}
	kernel_src_unpack
}

src_install() {
	kernel_src_install

	dosed 's:-r0::' /usr/src/linux-${KV}/Makefile
}

