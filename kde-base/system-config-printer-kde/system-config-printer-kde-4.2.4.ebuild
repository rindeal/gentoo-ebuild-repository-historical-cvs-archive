# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/system-config-printer-kde/system-config-printer-kde-4.2.4.ebuild,v 1.1 2009/06/04 13:55:57 alexxy Exp $

EAPI="2"

KMNAME="kdeadmin"
inherit kde4-meta python

DESCRIPTION="KDE port of Red Hat's Gnome system-config-printer"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	=app-admin/system-config-printer-common-1.1.3
	>=dev-python/PyQt4-4.4.4-r1[dbus]
	dev-python/pycups
	>=kde-base/pykde4-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	net-print/cups[dbus]
"
