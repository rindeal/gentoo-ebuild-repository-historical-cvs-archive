# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-system-monitor/gnome-system-monitor-2.0.0-r1.ebuild,v 1.3 2002/07/25 03:52:37 spider Exp $


inherit gnome2



S=${WORKDIR}/${P}
DESCRIPTION="Procman - The Gnome System Monitor"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
RDEPEND=">=x11-libs/gtk+-2.0.2
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/gconf-1.1.11
	>=gnome-base/libgtop-2.0.0
	>=x11-libs/libwnck-0.12
	>=gnome-base/libgnomecanvas-2.0.0
	>=app-text/scrollkeeper-0.3.6"

DEPEND=">=dev-util/pkgconfig-0.12.0
	 >=dev-util/intltool-0.17
	 ${RDEPEND}"
	 
DOCS="AUTHORS ChangeLog COPYING HACKING README* INSTALL NEWS TODO"

SCHEMAS="gnome-system-monitor.schemas"


