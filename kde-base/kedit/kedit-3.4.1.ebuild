# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kedit/kedit-3.4.1.ebuild,v 1.9 2005/09/13 09:36:50 agriffis Exp $

KMNAME=kdeutils
MAXKDEVER=3.4.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: very simple text editor"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""