# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/arrayterator/arrayterator-1.0.1.ebuild,v 1.1 2009/09/07 19:03:09 patrick Exp $

inherit distutils

DESCRIPTION="This class creates a buffered iterator for reading big arrays in
small contiguous blocks."
HOMEPAGE="http://pypi.python.org/pypi/arrayterator"

SRC_URI="http://cheeseshop.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
#IUSE="server"
IUSE=""
RDEPEND="virtual/python
	>=dev-python/numpy-1.0_rc1"
DEPEND="${RDEPEND}
	>=dev-python/setuptools-0.6_rc3"
