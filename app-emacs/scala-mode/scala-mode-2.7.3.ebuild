# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/scala-mode/scala-mode-2.7.3.ebuild,v 1.1 2009/02/11 15:58:03 ulm Exp $

EAPI=2

inherit elisp eutils

MY_P="scala-tool-support-${PV}.final"
DESCRIPTION="Scala mode for Emacs"
HOMEPAGE="http://www.scala-lang.org/"
SRC_URI="http://www.scala-lang.org/downloads/distrib/files/scala-packages/${MY_P}.sbp -> ${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="dev-lang/scala"

S="${WORKDIR}/misc/scala-tool-support/emacs/"
SITEFILE="50${PN}-gentoo.el"
DOCS="AUTHORS FUTURE README"

src_prepare() {
	epatch "${FILESDIR}/${P}-fix-bytecompile.patch"
}
