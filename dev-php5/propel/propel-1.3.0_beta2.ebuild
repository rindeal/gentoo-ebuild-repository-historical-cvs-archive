# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/propel/propel-1.3.0_beta2.ebuild,v 1.1 2007/03/20 18:44:46 chtekk Exp $

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Object Persistence Layer for PHP 5."
HOMEPAGE="http://propel.phpdb.org/trac/wiki/"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="~dev-php5/propel-generator-${PV}
		~dev-php5/propel-runtime-${PV}"
