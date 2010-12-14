# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-babel/flask-babel-0.6.ebuild,v 1.1 2010/12/14 22:50:18 rafaelmartins Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="Flask-Babel"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="i18n and l10n support for Flask based on Babel and pytz"
HOMEPAGE="http://packages.python.org/Flask-Babel/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND="dev-python/flask
	dev-python/Babel
	dev-python/pytz
	>=dev-python/speaklater-1.2
	>=dev-python/jinja-2.5"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="flaskext/babel.py"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		emake -C docs html || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/_build/html/* || die "Installation of documentation failed"
	fi
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" \
			cd tests; "$(PYTHON)" tests.py || die 'test failed.'
	}
	python_execute_function testing
}
