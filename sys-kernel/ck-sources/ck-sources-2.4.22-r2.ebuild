# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.4.22-r2.ebuild,v 1.1 2003/09/20 23:12:18 iggy Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  

ETYPE="sources"

inherit kernel

# CKV=con kolivas release version
CKV=ck${PR/r/}
# KV=patched kernel version
KV="${PV/_/-}-${CKV}"
# OKV=original kernel version as provided by ebuild
OKV="`echo ${KV} | cut -d- -f1`"
# OKVLAST=(working) last digit of OKV
OKVLAST="`echo ${OKV} | cut -d. -f3`"
# OKVLASTPR=the previous kernel version (for a marcelo pre/rc release)
OKVLASTPR="`expr ${OKVLAST} - 1`"
# If _ isn't there, then it's a stable+ac, otherwise last-stable+pre/rc+ac
PRERC="`echo ${PV}|grep \_`"

# Other working variables
S=${WORKDIR}/linux-${KV}
EXTRAVERSION="`echo ${KV}|sed -e 's:[^-]*\(-.*$\):\1:'`"
BASE="`echo ${KV}|sed -e s:${EXTRAVERSION}::`"

# If it's a last-stable+pre/rc+ac (marcelo), we need to handle it differently
# ourkernel is the stable kernel we'll be working with (previous or current)
if [ ${PRERC} ]; then
	OURKERNEL="2.4.${OKVLASTPR}"
	SRC_URI="mirror:/kernel/linux/kernel/v2.4/linux-${OURKERNEL}.tar.bz2
		http://members.optusnet.com.au/ckolivas/kernel/patch-${KV}.bz2
		mirror://kernel/linux/kernel/v2.4/testing/patch-${PV/_/-}.bz2"
else
	OURKERNEL="2.4.${OKVLAST}"
##### Fix Me : grossness until these showstopper bugs are in a full -ck patch
	SRC_URI="mirror:/kernel//linux/kernel/v2.4/linux-${OURKERNEL}.tar.bz2
		http://ck.kolivas.org/patches/2.4/2.4.22/2.4.22-ck2/fixes/patch-2.4.22-ck2-fix.patch
		http://ck.kolivas.org/patches/2.4/2.4.22/2.4.22-ck2/fixes/patch-2422-ck2-sm1.2.8-sm1.2.9-0309171736
		http://ck.kolivas.org/patches/2.4/${BASE}/${KV}/patch-${KV}.bz2"
		#http://members.optusnet.com.au/ckolivas/kernel/patch-${KV}.bz2"
fi

DESCRIPTION="Full sources for the Stock Linux kernel Con Kolivas's high performance patchset"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/kernel/"

KEYWORDS="x86 -ppc"
SLOT="${KV}"

src_unpack() {
	sleep 1
	unpack linux-${OURKERNEL}.tar.bz2
	mv linux-${OURKERNEL} linux-${KV} || die

	cd linux-${KV}

	# if we need a pre/rc patch, then use it
	if [ ${PRERC} ]; then
		bzcat ${DISTDIR}/patch-${PV/_/-}.bz2|patch -p1 || die "-marcelo patch failed"
	fi

	bzcat ${DISTDIR}/patch-${KV}.bz2|patch -p1 || die "-aa patch failed"

	kernel_universal_unpack
}

