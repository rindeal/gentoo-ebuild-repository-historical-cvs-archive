# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langcjk/texlive-langcjk-2008.ebuild,v 1.3 2009/02/27 15:20:17 fmccor Exp $

TEXLIVE_MODULE_CONTENTS="arphic c90enc cns garuda norasi uhc wadalab yi4latex hyphen-chinese collection-langcjk
"
TEXLIVE_MODULE_DOC_CONTENTS="arphic.doc cns.doc uhc.doc wadalab.doc yi4latex.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Chinese, Japanese, Korean"

LICENSE="GPL-2 as-is freedist LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2008
>=dev-texlive/texlive-documentation-chinese-2008
"
RDEPEND="${DEPEND}"
