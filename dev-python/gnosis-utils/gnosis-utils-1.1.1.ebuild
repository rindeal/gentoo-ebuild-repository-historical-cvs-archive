# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnosis-utils/gnosis-utils-1.1.1.ebuild,v 1.5 2006/07/12 15:36:23 agriffis Exp $

inherit distutils

IUSE=""
MY_P=${P/gnosis-utils/Gnosis_Utils}

S=${WORKDIR}/${MY_P}

DESCRIPTION="XML pickling and objectification with Python."
SRC_URI="http://www.gnosis.cx/download/${MY_P}.tar.gz"
HOMEPAGE="http://www.gnosis.cx/download/"

DEPEND="virtual/python"

SLOT="0"
KEYWORDS="ia64 x86"
LICENSE="PYTHON"

DOCS="README MANIFEST PKG-INFO"

src_install() {
	distutils_src_install

	distutils_python_version
	if [ -e "${D}/usr/lib/python${PYVER}/site-packages/gnosis/doc" ] ; then
		einfo "Moving documentation to correct location"
		mv ${D}/usr/lib/python${PYVER}/site-packages/gnosis/doc ${D}/usr/share/doc/${PF}/doc
	fi
}
