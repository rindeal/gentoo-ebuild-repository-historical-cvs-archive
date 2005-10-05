# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/memo/memo-1.9.5.ebuild,v 1.1 2005/10/05 13:10:32 svyatogor Exp $

inherit rox

MY_PN="Memo"
DESCRIPTION="Memo - Memo is a simple alarm clock for the ROX Desktop."
HOMEPAGE="http://rox.sourceforge.net/phpwiki/index.php/Memo"
SRC_URI="mirror://sourceforge/rox/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

ROX_LIB_VER=1.9.8

APPNAME=${MY_PN}
S=${WORKDIR}/${MY_PN}-${PV}
