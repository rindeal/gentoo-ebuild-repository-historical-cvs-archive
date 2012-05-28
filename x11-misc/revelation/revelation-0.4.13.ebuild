# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/revelation/revelation-0.4.13.ebuild,v 1.1 2012/05/28 21:58:14 tristan Exp $

EAPI=4

PYTHON_DEPEND="2"
GCONF_DEBUG="no"

inherit python gnome2

DESCRIPTION="A password manager for GNOME"
HOMEPAGE="http://revelation.olasagasti.info/"
SRC_URI="https://bitbucket.org/erikg/revelation/downloads/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="applet"
RESTRICT="test"

RDEPEND="dev-python/pygtk
	dev-python/pycrypto
	dev-python/gconf-python
	dev-python/gnome-vfs-python
	dev-python/libbonobo-python
	dev-python/libgnome-python
	sys-libs/cracklib[python]
	applet? ( dev-python/gnome-applets-python )"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
	gnome2_src_prepare
	echo -n > py-compile
}

src_configure() {
	gnome2_src_configure \
		--disable-desktop-update \
		--disable-mime-update \
		$(use_with applet)
}

src_install() {
	dodoc AUTHORS ChangeLog NEWS README TODO
	gnome2_src_install
	python_clean_installation_image
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize ${PN}
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup ${PN}
}
