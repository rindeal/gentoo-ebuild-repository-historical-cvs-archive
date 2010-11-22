# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/conque/conque-2.0.ebuild,v 1.1 2010/11/22 21:29:03 radhermit Exp $

EAPI=3

VIM_PLUGIN_VIM_VERSION="7.1"
inherit vim-plugin

MY_P="${PN}_${PV}"

DESCRIPTION="vim plugin: Run interactive commands inside a Vim buffer"
HOMEPAGE="http://code.google.com/p/conque/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( app-editors/vim[python] app-editors/gvim[python] )
	>=dev-lang/python-2.3"

VIM_PLUGIN_HELPFILES="ConqueTerm"

S="${WORKDIR}/${MY_P}"
