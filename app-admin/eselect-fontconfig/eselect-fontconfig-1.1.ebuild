# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-fontconfig/eselect-fontconfig-1.1.ebuild,v 1.1 2009/11/14 22:00:47 dirtyepic Exp $

DESCRIPTION="An eselect module to manage /etc/fonts/conf.d symlinks."
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/fontconfig.eselect-${PV}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=">=app-admin/eselect-1.2.3
		 >=media-libs/fontconfig-2.4"

S=${WORKDIR}

src_install() {
	insinto /usr/share/eselect/modules
	newins "${S}"/fontconfig.eselect-${PV} fontconfig.eselect || die
}
