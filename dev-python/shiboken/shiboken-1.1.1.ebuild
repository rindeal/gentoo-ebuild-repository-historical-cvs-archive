# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/shiboken/shiboken-1.1.1.ebuild,v 1.1 2012/04/28 17:42:56 pesa Exp $

EAPI=4

PYTHON_DEPEND="2:2.6 3:3.2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.1 *-jython 2.7-pypy-*"

inherit multilib cmake-utils python

DESCRIPTION="A tool for creating Python bindings for C++ libraries"
HOMEPAGE="http://www.pyside.org/"
SRC_URI="http://www.pyside.org/files/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-libs/libxml2-2.6.32
	>=dev-libs/libxslt-1.1.19
	>=x11-libs/qt-core-4.7.0:4
	>=x11-libs/qt-xmlpatterns-4.7.0:4
	!dev-python/apiextractor
	!dev-python/generatorrunner
"
DEPEND="${RDEPEND}
	test? (
		>=x11-libs/qt-gui-4.7.0:4
		>=x11-libs/qt-test-4.7.0:4
	)"

DOCS=( AUTHORS ChangeLog )

src_prepare() {
	# Fix inconsistent naming of libshiboken.so and ShibokenConfig.cmake,
	# caused by the usage of a different version suffix with python >= 3.2
	sed -i -e "/get_config_var('SOABI')/d" \
		cmake/Modules/FindPython3InterpWithDebug.cmake || die
}

src_configure() {
	configuration() {
		local mycmakeargs=(
			-DPYTHON_EXECUTABLE="$(PYTHON -a)"
			-DPYTHON_SUFFIX="-python${PYTHON_ABI}"
			$(cmake-utils_use_build test TESTS)
		)

		if [[ $(python_get_version -l --major) == 3 ]]; then
			mycmakeargs+=(
				-DUSE_PYTHON3=ON
				-DPYTHON3_INCLUDE_DIR="$(python_get_includedir)"
				-DPYTHON3_LIBRARY="$(python_get_library)"
			)
		fi

		CMAKE_BUILD_DIR="${S}_${PYTHON_ABI}" cmake-utils_src_configure
	}
	python_execute_function configuration
}

src_compile() {
	compilation() {
		CMAKE_BUILD_DIR="${S}_${PYTHON_ABI}" cmake-utils_src_make
	}
	python_execute_function compilation
}

src_test() {
	testing() {
		CMAKE_BUILD_DIR="${S}_${PYTHON_ABI}" cmake-utils_src_test
	}
	python_execute_function testing
}

src_install() {
	installation() {
		CMAKE_BUILD_DIR="${S}_${PYTHON_ABI}" cmake-utils_src_install
		mv "${ED}"usr/$(get_libdir)/pkgconfig/${PN}{,-python${PYTHON_ABI}}.pc || die
	}
	python_execute_function installation
}
