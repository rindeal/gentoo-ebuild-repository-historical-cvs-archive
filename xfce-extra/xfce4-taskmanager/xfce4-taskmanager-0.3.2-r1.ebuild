# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-taskmanager/xfce4-taskmanager-0.3.2-r1.ebuild,v 1.10 2008/04/25 15:47:28 drac Exp $

inherit autotools eutils xfce44

xfce44

DESCRIPTION="Task Manager"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfce4-taskmanager"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${P}${COMPRESS}"

RDEPEND=">=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}"
DEPEND="${RDEPEND}
	xfce-extra/xfce4-dev-tools"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "/^AC_INIT/s/taskmanager_version()/taskmanager_version/" configure.in
	AT_M4DIR=/usr/share/xfce4/dev-tools/m4macros eautoreconf
}

src_install() {
	xfce44_src_install
	make_desktop_entry ${PN} "Task Manager" xfce-system-settings "System;Utility;Core;GTK"
}
