# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.4.25-r2.ebuild,v 1.2 2004/05/03 07:41:37 kumba Exp $


# Version Data
OKV=${PV/_/-}
CVSDATE="20040222"
EXTRAVERSION="-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"
COBALTPATCHVER="1.4"

# Miscellaneous stuff
S=${WORKDIR}/linux-${OKV}-${CVSDATE}
IUSE=""

# Eclass stuff
ETYPE="sources"
inherit kernel eutils


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 28 Nov 2003
# 3) patch to fix arch/mips[64]/Makefile to pass appropriate CFLAGS
# 4) patch to fix the mips64 Makefile to allow building of mips64 kernels
# 5) iso9660 fix
# 6) Patches for Cobalt support


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/cobalt-patches-24xx-${COBALTPATCHVER}.tar.bz2"
HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-* mips"


src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${OKV}-${CVSDATE}
	cd ${S}

	# Update the vanilla sources with linux-mips CVS changes
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# Patch arch/mips/Makefile for gcc (Pass -mips3/-mips4 for r4k/r5k cpus)
	epatch ${FILESDIR}/mipscvs-${OKV}-makefile-fix.patch

	# Patch to fix mips64 Makefile so that -finline-limit=10000 gets added to CFLAGS
	epatch ${FILESDIR}/mipscvs-${OKV}-makefile-inlinelimit.patch

	# Binutils-2.14.90.0.8 and does some magic with page alignment
	# that prevents the kernel from booting.  This patch fixes it.
	epatch ${FILESDIR}/mipscvs-${OKV}-no-page-align.patch

	# Security Fixes
	echo -e ""
		ebegin "Applying Security Fixes"
		epatch ${FILESDIR}/CAN-2004-0109-2.4-iso9660.patch
		epatch ${FILESDIR}/CAN-2004-0177-ext3_jbd.patch
		epatch ${FILESDIR}/CAN-2004-0178-sbblaster.patch
	eend

	# Cobalt Patches
	if [ "${PROFILE_ARCH}" = "cobalt" ]; then
		echo -e ""
		einfo ">>> Patching kernel for Cobalt support ..."
		for x in ${WORKDIR}/cobalt-patches-24xx-${COBALTPATCHVER}/*.patch; do
			epatch ${x}
		done
		cp ${WORKDIR}/cobalt-patches-24xx-${COBALTPATCHVER}/cobalt-patches.txt ${S}
		cd ${WORKDIR}
		mv ${WORKDIR}/linux-${OKV}-${CVSDATE} ${WORKDIR}/linux-${OKV}-${CVSDATE}.cobalt
		S="${S}.cobalt"
	fi

	kernel_universal_unpack
}
