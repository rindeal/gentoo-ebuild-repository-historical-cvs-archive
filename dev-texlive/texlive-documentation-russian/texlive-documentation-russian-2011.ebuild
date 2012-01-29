# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-russian/texlive-documentation-russian-2011.ebuild,v 1.5 2012/01/29 18:25:00 maekke Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="lshort-russian mpman-ru texlive-ru collection-documentation-russian
"
TEXLIVE_MODULE_DOC_CONTENTS="lshort-russian.doc mpman-ru.doc texlive-ru.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit  texlive-module
DESCRIPTION="TeXLive Russian documentation"

LICENSE="GPL-2 as-is GPL-1 "
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2011
"
RDEPEND="${DEPEND} "
