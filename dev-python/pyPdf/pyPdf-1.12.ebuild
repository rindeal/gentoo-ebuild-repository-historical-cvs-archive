# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyPdf/pyPdf-1.12.ebuild,v 1.4 2009/04/28 17:57:45 zmedico Exp $

inherit distutils

DESCRIPTION="Python library to work with pdf files"
HOMEPAGE="http://pybrary.net/${PN}/"
SRC_URI="http://pybrary.net/${PN}/${P}.tar.gz"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="!=app-text/calibre-0.5.9"
