# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstart/kstart-3.5.0.ebuild,v 1.3 2005/12/04 10:21:55 kloeri Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Utility to launch applications with special window properties"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
IUSE=""


