# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.4.22-r8.ebuild,v 1.1 2004/02/01 10:32:30 kumba Exp $

ETYPE="sources"
inherit kernel

OKV=${PV/_/-}
CVSDATE=20031015
S=${WORKDIR}/linux-${OKV}-${CVSDATE}
EXTRAVERSION=-mipscvs-${CVSDATE}
KV="${OKV}${EXTRAVERSION}"

inherit eutils

# What's in this kernel?

# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 15 Oct 2003
# 3) patch to fix arch/mips[64]/Makefile to pass appropriate CFLAGS
# 4) patch to tweak arch/mips64/Makefile to pass -Wa,-mabi=o64 instead of -Wa,-32


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/cobalt-patches-2.4.tar.bz2"
HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-* ~mips"

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${OKV}-${CVSDATE}
	cd ${S}

	# Update the vanilla sources with linux-mips CVS changes
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# Patch arch/mips/Makefile for gcc (Pass -mips3/-mips4 for r4k/r5k cpus)
	epatch ${FILESDIR}/mipscvs-${OKV}-makefile-fix.patch

	# Patch arch/mips64/Makefile to pass -Wa,mabi=o64 (Allows building of mips64 kernels)
	epatch ${FILESDIR}/mipscvs-${OKV}-makefile-mips64-tweak.patch

	# do_brk fix (Fixes exploit that hit several debian servers)
	epatch ${FILESDIR}/do_brk_fix.patch

	# mremap fix (Possibly Exploitable)
	epatch ${FILESDIR}/mremap-fix-try2.patch

	# MIPS RTC Fixes (Fixes memleaks, backport from 2.4.24)
	epatch ${FILESDIR}/rtc-fixes.patch

	# Cobalt Patches
	if [ "${PROFILE_ARCH}" = "cobalt" ]; then
		for x in ${WORKDIR}/cobalt-patches-2.4/*.patch; do
			epatch ${x}
		done
	fi

	kernel_universal_unpack
}
