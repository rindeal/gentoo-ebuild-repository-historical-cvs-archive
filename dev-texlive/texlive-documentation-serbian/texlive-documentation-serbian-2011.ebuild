# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-serbian/texlive-documentation-serbian-2011.ebuild,v 1.5 2012/01/29 18:27:14 maekke Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="texlive-sr collection-documentation-serbian
"
TEXLIVE_MODULE_DOC_CONTENTS="texlive-sr.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit  texlive-module
DESCRIPTION="TeXLive Serbian documentation"

LICENSE="GPL-2 "
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2011
"
RDEPEND="${DEPEND} "
