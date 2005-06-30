# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcmcia-cs/pcmcia-cs-3.2.7-r4.ebuild,v 1.3 2005/06/30 09:11:47 brix Exp $

inherit eutils linux-info

OV="orinoco-0.13e"

DESCRIPTION="PCMCIA tools for Linux"
SRC_URI="mirror://sourceforge/pcmcia-cs/${P}.tar.gz
		http://dev.gentoo.org/~latexer/files/patches/${P}-module-init-tools.diff.gz
		ppc? ( http://dev.gentoo.org/~latexer/files/patches/pcmcia-cs-3.2.5-ppc-fix.diff.gz )
		http://ozlabs.org/people/dgibson/dldwd/monitor-0.13e.patch"

HOMEPAGE="http://pcmcia-cs.sourceforge.net"
IUSE="X trusted build apm pnp nocardbus"
DEPEND="virtual/os-headers
		>=sys-apps/sed-4
		X? ( virtual/x11 )"
RDEPEND="!sys-apps/pcmcia-cs-cis"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~mips"
PROVIDE="virtual/pcmcia"

src_unpack() {
	unpack ${P}.tar.gz || die "unpack failed"

	# 3.2.7 includes the latest stable orinoco (0.13e), so just patch to add
	# monitor mode
	cd ${S}/wireless
	epatch ${DISTDIR}/monitor-0.13e.patch

	cd ${S}

	# Fix for module-init-tools systems
	epatch ${DISTDIR}/${P}-module-init-tools.diff.gz

	# Fix for ppc on newer benh kernels
	[ "${ARCH}" == "ppc" ] && epatch ${DISTDIR}/pcmcia-cs-3.2.5-ppc-fix.diff.gz

	# Install man-pages into /usr/share/man
	sed -i -e 's:usr/man:usr/share/man:g' Configure \
		|| die "sed Configure failed (2)"

	epatch ${FILESDIR}/pcmcia-cs-3.2.7-move-pnp-ids-to-usr-share-misc.patch

	# Install cardinfo and xcardinfo into /usr/bin instead of /usr/X11R6/bin
	cd ${S}
	epatch ${FILESDIR}/cardinfo-install-3.2.7.patch
}

src_compile() {
	local myconf myarch

	# There's now a configure option for whether to build X tools
	if use X; then
		myconf="${myconf} --x11"
	else
		myconf="${myconf} --nox11"
	fi

	if use trusted; then
		myconf="${myconf} --trust"
	else
		myconf="${myconf} --notrust"
	fi

	# Note that when built with apm support, pcmcia-cs will require a
	# kernel with APM support
	if use apm; then
		myconf="${myconf} --apm"
	else
		myconf="${myconf} --noapm"
	fi

	# Note that when built with pnp support, pcmcia-cs will require a
	# kernel with ISA PnP support
	if use pnp; then
		myconf="${myconf} --pnp"
	else
		myconf="${myconf} --nopnp"
	fi

	if use nocardbus; then
		myconf="${myconf} --nocardbus"
	else
		myconf="${myconf} --cardbus"
	fi

	set_arch_to_kernel
	# Use $CFLAGS for user tools, but standard kernel optimizations
	# for the kernel modules (for compatibility).
	#
	# The --srctree option tells pcmcia-cs to configure for the kernel
	# in /usr/src/linux rather than the currently-running kernel.
	# It's Gentoo Linux policy to configure for
	# the kernel in /usr/src/linux
	./Configure -n \
		--target=${D} \
		--srctree \
		--kernel=${KV_DIR} \
		--arch="${myarch}" \
		--uflags="$CFLAGS" \
		--kflags="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer" \
		$myconf || die "failed configuring"

	sed -i -e '/^HAS_FORMS/d ; s/^FLIBS=".*"/FLIBS=""/' config.out config.mk

	ebegin "Building pcmcia-cs development environment"
	echo ${PV} > ${S}/pcmcia-cs-version
	cd ${S}
	tar -cjf ${T}/pcmcia-cs-build-env.tbz2 .
	eend ${?}

	emake DO_ORINOCO=1 all || die "failed compiling"
}

src_install () {
	dodir /usr/share/misc

	make PREFIX=${D} install || die "failed installing"
	set_arch_to_portage

	# remove included rc scripts since we have our own
	rm -rf ${D}/etc/rc*.d

	insinto /etc/conf.d
	newins ${FILESDIR}/pcmcia.conf pcmcia

	exeinto /etc/pcmcia
	doexe ${FILESDIR}/network

	# install our own init script
	exeinto /etc/init.d
	newexe ${FILESDIR}/pcmcia.rc pcmcia

	# documentation
	if use build; then
		rm -rf ${D}/usr/share/man
	else
		dodoc BUGS CHANGES COPYING LICENSE MAINTAINERS README \
			README-2.4 SUPPORTED.CARDS doc/*
	fi
	rm -f ${D}/etc/modules.conf
	rm -rf ${D}/var/lib/pcmcia

	# if on ppc set the ppc revised config.opts
	if [ "${ARCH}" = "ppc" ]; then
		insinto /etc/pcmcia
		newins ${FILESDIR}/ppc.config.opts config.opts
	fi

	# install the pcmcia-cs development environment tarball
	insinto ${ROOT}/usr/src/pcmcia-cs/
	doins ${T}/pcmcia-cs-build-env.tbz2
}

pkg_postinst() {
	if [ ${KV_MINOR} -lt 5 ]
	then
		depmod -a

		einfo "To avail yourself of the pcmcia-cs drivers, you have to disable the"
		einfo "PCMCIA support in the kernel.  (Otherwise, you might experience"
		einfo "CardServices version mismatch errors)"
		einfo ""
		einfo "Proper kernel config for this package is that PCMCIA/CardBus under"
		einfo "General Setup is off and Wireless LAN (non-ham radio) is on but"
		einfo "no modules or drivers turned on under Network Device Support"
		einfo "if you have wireless."
		einfo ""
		einfo "Also note it now appears that you need CONFIG_CRC32 turned on"
		einfo "These are the CRC32 Library functions in the config"
	else
		einfo "For 2.5/2.6 kernels, the PCMCIA support from the kernel should"
		einfo "be used. Enable PCMCIA and any further drivers you need there,"
		einfo "and then use this package to install the PCMCIA tools."
	fi
}
