# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-sources/ppc-sources-2.4.24-r4.ebuild,v 1.2 2004/05/30 22:57:34 pvdabeel Exp $

# Included patches:
#  benh 2.4.24-0
#  pegasos 2.4.24-2
#  orinoco monitor 0.13
#  O_STREAMING 2.4.20-pre9-1
#  GRSecurity 2.0-rc4
#  ea+acl+nfsacl 0.8.65
#  XFS 2.4.23
#  Loop-Jari 2.4.22.0
#  FreeS/WAN 2.01
#  x509 1.4.5
#  Extra bootlogos
#  pmac_pmu fix, see bug #41668
#  munmap fix, see bug #42024

ETYPE="sources"
inherit kernel
IUSE=""

OKV="2.4.24"

EXTRAVERSION="`echo ${PV}-${PN/-sources/}-${PR} | \
	sed -e 's/[0-9]\+\.[0-9]\+\.[0-9]\+\(.*\)/\1/'`"

KV=${PV}-${PN/-sources/}-${PR}
S=${WORKDIR}/linux-${KV}

inherit eutils

DESCRIPTION="Full sources for the linux kernel 2.4.24 with benh's patchset"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/patch-${KV/r4/r2}.bz2"

KEYWORDS="-* ppc"
DEPEND=">=sys-devel/binutils-2.11.90.0.31"
RDEPEND=">=sys-libs/ncurses-5.2 dev-lang/perl virtual/modutils sys-devel/make"

SLOT=${KV}
PROVIDE="virtual/linux-sources"

src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2

	mv linux-${OKV} ${PF}
	cd ${PF}
	bzcat ${DISTDIR}/patch-${KV/r4/r2}.bz2 | patch -p1 || die "Patching failed!"
	epatch ${FILESDIR}/${P}.CAN-2004-0010.patch || die "Failed to add the CAN-2004-0010 patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-0109.patch || die "Failed to patch CAN-2004-0109 vulnerability!"
	epatch ${FILESDIR}/${P}.CAN-2004-0177.patch || die "Failed to add the CAN-2004-0177 patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-0178.patch || die "Failed to add the CAN-2004-0178 patch!"
	find . -iname "*~" | xargs rm 2> /dev/null

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	# also fix the EXTRAVERSION
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
		-e "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" \
			Makefile.orig >Makefile || die # test, remove me if Makefile ok
	rm Makefile.orig

	cd ${WORKDIR}/${PF}
	MY_ARCH=${ARCH}
	unset ARCH

	# Sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper || die "make mrproper died"
	ARCH=${MY_ARCH}
}

src_install() {
	dodir /usr/src
	echo ">>> Copying sources..."
	mv ${WORKDIR}/* ${D}/usr/src
}
pkg_postinst() {
	if [ ! -e ${ROOT}usr/src/linux ]
	then
		ln -sf ${PF} ${ROOT}/usr/src/linux
	fi
}
