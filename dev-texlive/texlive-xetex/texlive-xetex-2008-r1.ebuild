# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-xetex/texlive-xetex-2008-r1.ebuild,v 1.12 2010/01/15 10:39:42 grobian Exp $

TEXLIVE_MODULE_CONTENTS="arabxetex euenc bidi fontspec fontwrap philokalia polyglossia xecyr xepersian xetex xetex-def xetex-pstricks xetexconfig xetexfontinfo xltxtra xunicode collection-xetex
"
TEXLIVE_MODULE_DOC_CONTENTS="arabxetex.doc euenc.doc bidi.doc fontspec.doc fontwrap.doc philokalia.doc polyglossia.doc xecyr.doc xepersian.doc xetex.doc xetex-pstricks.doc xetexfontinfo.doc xltxtra.doc xunicode.doc "
TEXLIVE_MODULE_SRC_CONTENTS="euenc.source bidi.source fontspec.source philokalia.source polyglossia.source xltxtra.source "
inherit texlive-module
DESCRIPTION="TeXLive XeTeX packages"

LICENSE="GPL-2 Apache-2.0 as-is GPL-1 LPPL-1.3 OFL public-domain "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2008
!=app-text/texlive-core-2007*
"
RDEPEND="${DEPEND}"
