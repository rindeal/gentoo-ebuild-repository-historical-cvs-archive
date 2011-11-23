# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdemu/cdemu-1.2.0.ebuild,v 1.5 2011/11/23 10:14:26 tetromino Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="Command-line tool for controlling the CDEmu daemon (cdemud)"
HOMEPAGE="http://cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/cdemu-client-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/dbus-python
	~app-cdr/cdemud-${PV}"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21"

S=${WORKDIR}/cdemu-client-${PV}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# disable compilation of python modules
	rm py-compile && \
	ln -s "$(type -P true)" py-compile || die
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	python_mod_optimize cdemu
	python_need_rebuild
}

pkg_postrm() {
	python_mod_cleanup cdemu
}
