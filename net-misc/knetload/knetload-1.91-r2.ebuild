# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/knetload/knetload-1.91-r2.ebuild,v 1.2 2001/11/16 12:50:42 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kdelibs 2.1.1

DESCRIPTION="A Network applet for KDE2"
SRC_URI="http://kde.quakenet.eu.org/files/${P}.tar.gz"
HOMEPAGE="http://kde.quakenet.eu.org/knetload.shtml"


