# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-1.4-r3.ebuild,v 1.6 2002/08/28 23:21:57 spider Exp $

S=${WORKDIR}
DESCRIPTION="GNOME 1.4 - merge this package to merge all GNOME base packages"
HOMEPAGE="http://www.gnome.org/"
KEYWORDS="x86 ppc sparc sparc64"
LICENSE="as-is"
SLOT="1.4"
RDEPEND=">=gnome-base/gnome-core-1.4.0.4-r1
	 <gnome-base/gnome-applets-2
     <gnome-base/nautilus-2
	 <gnome-base/gdm-2.4
	 <x11-wm/sawfish-2"

