# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kturtle/kturtle-4.1.3.ebuild,v 1.2 2008/11/16 08:10:52 vapier Exp $

EAPI="2"

KMNAME=kdeedu
inherit kde4-meta

DESCRIPTION="KDE: Educational programming environment using the Logo programming language"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND=">=kde-base/knotify-${PV}:${SLOT}"
