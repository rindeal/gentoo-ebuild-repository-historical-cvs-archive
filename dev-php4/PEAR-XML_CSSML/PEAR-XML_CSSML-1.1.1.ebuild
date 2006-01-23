# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/PEAR-XML_CSSML/PEAR-XML_CSSML-1.1.1.ebuild,v 1.7 2006/01/23 17:58:37 kloeri Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="A template system for generating cascading style sheets (CSS)"
LICENSE="PHP"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ppc64 sparc x86"
IUSE=""

pkg_postinst () {
	ewarn "The XML_CSSML PEAR package is unmaintained and requires"
	ewarn "PHP 4 built with the DOMXML extension (USE=xml2)."
}

need_php_by_category
