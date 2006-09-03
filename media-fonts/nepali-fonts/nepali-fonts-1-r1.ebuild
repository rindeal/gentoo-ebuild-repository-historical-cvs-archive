# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/nepali-fonts/nepali-fonts-1-r1.ebuild,v 1.13 2006/09/03 06:42:44 vapier Exp $

inherit font

DESCRIPTION="a collection of fonts for Nepali users"
HOMEPAGE="http://www.mpp.org.np/ http://www.nepali.info/ http://www.nepalipost.com/ http://www.moics.gov.np/download/fonts.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc s390 sh sparc x86"
IUSE=""

DEPEND=""

S="${WORKDIR}/${PN}"
FONT_S=${S}
FONT_SUFFIX="ttf"
