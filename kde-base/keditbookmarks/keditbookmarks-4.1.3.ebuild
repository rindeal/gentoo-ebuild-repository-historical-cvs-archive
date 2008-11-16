# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/keditbookmarks/keditbookmarks-4.1.3.ebuild,v 1.2 2008/11/16 07:30:12 vapier Exp $

EAPI="2"

KMNAME=kdebase
KMMODULE=apps/$PN
inherit kde4-meta

DESCRIPTION="KDE's bookmarks editor"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/libkonq-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="apps/lib/konq/"
