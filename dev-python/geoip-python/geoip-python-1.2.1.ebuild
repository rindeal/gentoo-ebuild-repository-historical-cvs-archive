# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/geoip-python/geoip-python-1.2.1.ebuild,v 1.2 2006/04/01 14:57:30 agriffis Exp $

inherit distutils

MY_P=${P/geoip-python/GeoIP-Python}
DESCRIPTION="Python Bindings for GeoIP"
HOMEPAGE="http://www.maxmind.com/app/python"
SRC_URI="http://www.maxmind.com/download/geoip/api/python/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/geoip-1.2.1
	virtual/python"

S=${WORKDIR}/${MY_P}
DOCS="README ChangeLog test.py test_city.py test_org.py"
