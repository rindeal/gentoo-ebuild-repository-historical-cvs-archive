# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-freedict-eng-swe/stardict-freedict-eng-swe-2.4.2.ebuild,v 1.6 2005/01/01 13:00:13 eradicator Exp $

FROM_LANG="English"
TO_LANG="Swedish"
DICT_PREFIX="dictd_www.freedict.de_"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_dictd-www.freedict.de.php"

KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND=">=app-dicts/stardict-2.4.2"
