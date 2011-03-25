# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/cvs2svn/cvs2svn-2.2.0.ebuild,v 1.4 2011/03/25 21:25:47 arfrever Exp $

EAPI="2"
PYTHON_DEPEND="2"
PYTHON_USE_WITH_OR="berkdb gdbm"
PYTHON_USE_WITH_OPT="test"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit eutils distutils

FILEVER="44372"

DESCRIPTION="Convert a CVS repository to a Subversion repository"
HOMEPAGE="http://cvs2svn.tigris.org/"
SRC_URI="http://cvs2svn.tigris.org/files/documents/1462/${FILEVER}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="bazaar git test"

DEPEND=">=dev-vcs/subversion-1.0.9"
RDEPEND="${DEPEND}
	bazaar? ( >=dev-vcs/bzr-1.13 )
	git? ( >=dev-vcs/git-1.5.4.4 )
	dev-vcs/rcs"

PYTHON_MODNAME="cvs2svn_lib cvs2svn_rcsparse"

src_prepare() {
	epatch "${FILESDIR}/2.2.0-deprecated-modules.patch"
	distutils_src_prepare
	python_convert_shebangs -r 2 .
}

src_install() {
	distutils_src_install
	insinto "/usr/share/${PN}"
	doins -r contrib cvs2svn-example.options
	doman cvs2svn.1
}

src_test() {
	# Need this because subversion is localized, but the tests aren't
	export LC_ALL=C

	testing() {
		"$(PYTHON)" -W ignore run-tests.py
	}
	python_execute_function testing
}

pkg_postinst() {
	distutils_pkg_postinst
	elog "Additional scripts and examples have been installed to:"
	elog "  /usr/share/${PN}/"
}
