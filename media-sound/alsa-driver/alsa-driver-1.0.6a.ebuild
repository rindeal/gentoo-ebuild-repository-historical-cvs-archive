# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-driver/alsa-driver-1.0.6a.ebuild,v 1.5 2004/11/12 10:41:43 eradicator Exp $

IUSE="oss"

inherit kernel-mod flag-o-matic eutils

MY_P=${P/_rc/rc}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Advanced Linux Sound Architecture kernel modules"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/driver/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="${KV}"
KEYWORDS="~alpha amd64 ~ia64 ~mips ~ppc -sparc x86"

RDEPEND="virtual/modutils
	 ~media-sound/alsa-headers-${PV}"

DEPEND="${RDEPEND}
	virtual/linux-sources
	sys-devel/autoconf
	sys-apps/debianutils"

PROVIDE="virtual/alsa"

# By default, drivers for all supported cards will be compiled.
# If you want to only compile for specific card(s), set ALSA_CARDS
# environment to a space-separated list of drivers that you want to build.
# For example:
#
#   env ALSA_CARDS='emu10k1 intel8x0 ens1370' emerge alsa-driver
#
[ -z "${ALSA_CARDS}" ] && ALSA_CARDS=all

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-1.0.5-devfix.patch
	epatch ${FILESDIR}/${PN}-1.0.5a-cs46xx-passthrough.patch

	if [ "${PROFILE_ARCH}" == "xbox" ]; then
		epatch ${FILESDIR}/${PN}-1.0.5a-xbox-ac97.patch
	fi

	if kernel-mod_is_2_5_kernel || (kernel-mod_is_2_6_kernel && [ ${KV_PATCH} -lt 6 ]); then
		FULL_KERNEL_PATH="${ROOT}/usr/src/${KV_DIR}"

		if ! [ -d "${FULL_KERNEL_PATH}" ]; then
			eerror "An error seems to have occurred.  We looked in ${FULL_KERNEL_PATH} for your kernel sources, but we didn't see them."
			die "ALSA driver configuration failure."
		fi

		einfo "A 2.5 or 2.6 kernel was detected.  We are copying the kernel source tree from"
		einfo "${FULL_KERNEL_PATH} to ${T}/linux"
		einfo "because the alsa-driver build process overwrites files in the 2.6.x kernel tree."

		# Copy everything over to our tmp dir...
		cp -a ${FULL_KERNEL_PATH} ${T}/linux
	else
		# SUBDIRS -> M
		epatch ${FILESDIR}/${PN}-1.0.6a-kbuild.patch
	fi
}

src_compile() {
	# Default ARCH & kernel path to set in compilation and make
	KER_DIR=${KERNEL_DIR}

	# If we're using a 2.5 or 2.6 kernel, use our copied kernel tree.
	if [ -d "${T}/linux" ]; then
		KER_DIR="${T}/linux"
	fi

	econf `use_with oss` \
		--with-kernel="${KER_DIR}" \
		--with-isapnp=yes \
		--with-sequencer=yes \
		--with-cards="${ALSA_CARDS}" || die "econf failed"

	# Should fix bug #46901
	is-flag "-malign-double" && filter-flags "-fomit-frame-pointer"

	unset ARCH
	emake || die "Parallel Make Failed"
}


src_install() {
	dodir /usr/include/sound
	make DESTDIR=${D} install || die

	# Provided by alsa-headers now
	rm -rf ${D}/usr/include/sound

	# We have our own scripts in alsa-utils
	test -e ${D}/etc/init.d/alsasound && rm ${D}/etc/init.d/alsasound
	test -e ${D}/etc/rc.d/init.d/alsasound && rm ${D}/etc/rc.d/init.d/alsasound

	rm doc/Makefile
	dodoc CARDS-STATUS COPYING FAQ INSTALL README WARNING TODO doc/*
}

pkg_postinst() {
	if [ "${ROOT}" = / ]
	then
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
	fi

	einfo
	einfo "The alsasound initscript and modules.d/alsa have now moved to alsa-utils"
	einfo
	einfo "Also, remember that all mixer channels will be MUTED by default."
	einfo "Use the 'alsamixer' program to unmute them."
	einfo
	einfo "Version 1.0.3 and above should work with version 2.6 kernels."
	einfo "If you experience problems, please report bugs to http://bugs.gentoo.org."
	einfo
}
