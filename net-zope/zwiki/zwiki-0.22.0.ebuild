# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zwiki/zwiki-0.22.0.ebuild,v 1.1 2003/10/13 13:37:33 lanius Exp $

inherit zproduct

DESCRIPTION="A zope wiki-clone for easy-to-edit collaborative websites."
HOMEPAGE="http://zwiki.org/"
SRC_URI="${HOMEPAGE}/releases/ZWiki-${PV}.tgz
	http://www.zope.org/Members/simon/ZWiki/ZWiki-${PV}.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

ZPROD_LIST="ZWiki"
MYDOC="ChangeLog GPL.txt ${MYDOC}"

