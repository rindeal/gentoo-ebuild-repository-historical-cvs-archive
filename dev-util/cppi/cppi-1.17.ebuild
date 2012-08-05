# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppi/cppi-1.17.ebuild,v 1.1 2012/08/05 00:50:26 jer Exp $

EAPI=4

DESCRIPTION="a cpp directive indenter"
HOMEPAGE="http://savannah.gnu.org/projects/cppi"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

CPPI_LINGUAS="de eo fi fr hr it ja pl sr sv uk vi"
for  lingua in ${CPPI_LINGUAS}; do
	IUSE+=" linguas_${lingua}"
done

DEPEND="
	app-arch/xz-utils
	nls? ( sys-devel/gettext )
"

DOCS=( AUTHORS ChangeLog NEWS THANKS TODO )

src_configure() {
	econf $(use_enable nls)
}
