# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/spacenavd/spacenavd-0.5-r1.ebuild,v 1.1 2012/02/06 19:51:21 sping Exp $

EAPI="4"

inherit eutils linux-info toolchain-funcs

MY_PN='spacenav'
DESCRIPTION="The spacenavd daemon provides free alternative to the 3dxserv daemon."
HOMEPAGE="http://spacenav.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/${MY_PN}/${MY_PN}%20daemon/${PN}%20${PV}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

RDEPEND="X? ( x11-apps/xdpyinfo )"
DEPEND="${RDEPEND}"

pkg_setup() {
	CONFIG_CHECK="~HOTPLUG"
	ERROR_CFG="Your kernel needs HOTPLUG for the spacenavd to work properly"
	check_extra_config
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-destdir.patch
	epatch "${FILESDIR}"/${P}-custom-flags.patch
}

src_configure() {
	econf \
		--enable-opt --enable-ldopt \
		$(use_enable X x11)
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	# Config file
	insinto /etc
	newins "${S}/doc/example-spnavrc" spnavrc.sample || die

	# Init script
	newinitd "${FILESDIR}/spnavd" spacenavd || die

	# Daemon
	dobin "${S}/spacenavd"
	use X && dobin "${S}/spnavd_ctl"
}

pkg_postinst() {
	elog "To start the Spacenav daemon system-wide by default"
	elog "you should add it to the default runlevel :"
	elog "\`rc-update add spacenavd default\`"
	elog
	if use X; then
		elog "To start generating Spacenav X events by default"
		elog "you should add this command in your user startup"
		elog "scripts such as .gnomerc or .xinitrc :"
		elog "\`spnavd_ctl x11 start\`"
		elog
	fi
	ewarn "You must restart spnavd \`/etc/init.d/spacenavd restart\` to run"
	ewarn "the new version of the daemon."
}
