# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/gentoo-syntax/gentoo-syntax-1.18.ebuild,v 1.1 2010/10/23 07:28:30 graaff Exp $

inherit xemacs-elisp eutils

DESCRIPTION="An Emacs mode for editing ebuilds and other Gentoo specific files."
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/index.xml"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-editors/xemacs-21.4.20-r5
	app-xemacs/sh-script"
DEPEND="${RDEPEND}"
