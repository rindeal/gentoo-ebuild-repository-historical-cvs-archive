# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/wxperl/wxperl-0.990.0.ebuild,v 1.1 2011/06/06 17:03:33 tove Exp $

EAPI=4

MY_PN=Wx
WX_GTK_VER="2.8"
MODULE_AUTHOR=MDOOTSON
MODULE_VERSION=0.99
inherit wxwidgets perl-module

DESCRIPTION="Perl bindings for wxGTK"
HOMEPAGE="http://wxperl.sourceforge.net/"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-perl/Alien-wxWidgets-0.25
	>=virtual/perl-File-Spec-0.82"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-ParseXS-0.22.03
	>=dev-perl/ExtUtils-XSpp-0.160.100"

MAKEOPTS="${MAKEOPTS} -j1"
