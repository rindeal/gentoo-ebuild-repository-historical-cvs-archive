# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/xrdb-mode/xrdb-mode-2.31.ebuild,v 1.9 2007/07/03 19:54:36 ulm Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing X resource database files"
HOMEPAGE="http://www.python.org/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

SITEFILE=70${PN}-gentoo.el
