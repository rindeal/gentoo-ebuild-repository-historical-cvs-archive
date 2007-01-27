# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/linux-fusion/linux-fusion-3.2-r1.ebuild,v 1.2 2007/01/27 11:26:05 vapier Exp $

inherit linux-mod

DESCRIPTION="provide statistical information for the Linux /proc file system"
HOMEPAGE="http://directfb.org/wiki/index.php/Fusion_Proc_Filesystem"
SRC_URI="http://directfb.org/downloads/Core/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="udev"

MODULE_NAMES="fusion(drivers/char:${S}:${S}/linux/drivers/char/fusion)"
BUILD_TARGETS="all"
MODULESD_REALTIME_DOCS="AUTHORS ChangeLog README"

pkg_setup() {
	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/linux-fusion-3.2-newer-kernel.patch #163740
	convert_to_m Makefile
}

src_install() {
	linux-mod_src_install
	insinto /usr/include/linux
	doins "${S}"/linux/include/linux/fusion.h || die
	dodoc README ChangeLog TODO
	if use udev ; then
		insinto /etc/udev/rules.d
		newins "${FILESDIR}"/fusion.udev 60-fusion.rules
	fi
}
