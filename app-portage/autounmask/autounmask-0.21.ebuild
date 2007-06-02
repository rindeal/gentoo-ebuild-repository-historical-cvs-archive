# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/autounmask/autounmask-0.21.ebuild,v 1.1 2007/06/02 20:31:11 ian Exp $

DESCRIPTION="autounmask - Unmasking packages the easy way"
HOMEPAGE="http://download.mpsna.de/opensource/autounmask/"
SRC_URI="http://download.mpsna.de/opensource/autounmask/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl
		>=dev-perl/PortageXS-0.02.07
		dev-perl/Term-ANSIColor
		dev-perl/Shell-EnvImporter"
RDEPEND="${DEPEND}
		sys-apps/portage"

src_install() {
	dobin autounmask || die
	dodoc Changelog
}
