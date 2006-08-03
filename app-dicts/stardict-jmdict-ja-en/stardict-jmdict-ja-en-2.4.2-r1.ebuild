# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-jmdict-ja-en/stardict-jmdict-ja-en-2.4.2-r1.ebuild,v 1.3 2006/08/03 18:09:23 gustavoz Exp $

FROM_LANG="Japanese"
TO_LANG="English"
DICT_PREFIX="jmdict-"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_ja.php"
SRC_URI="mirror://sourceforge/stardict/${P}.tar.bz2"

LICENSE="GDLS"
KEYWORDS="~ppc sparc x86"
IUSE=""

RDEPEND=">=app-dicts/stardict-2.4.2"

src_install() {
	stardict_src_install
	dodoc README
}
