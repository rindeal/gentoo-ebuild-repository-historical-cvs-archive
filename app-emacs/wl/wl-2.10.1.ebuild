# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/wl/wl-2.10.1.ebuild,v 1.2 2003/07/07 18:27:39 nakano Exp $

inherit elisp

IUSE="ssl"
DESCRIPTION="a mail/news reader supporting IMAP4rev1 for emacsen"
HOMEPAGE="http://www.gohome.org/wl/index.html"
SRC_URI="ftp://ftp.gohome.org/wl/stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc ~ppc"

DEPEND="virtual/emacs
         >=app-emacs/apel-10.3
         >=app-emacs/flim-1.14.3
         >=app-emacs/semi-1.14.3"
#        >=virtual/flim-1.14.3
#        >=virtual/semi-1.14.3

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	if [ -n "`use ssl`" ] ; then
		cd ${S}
		echo "(setq wl-install-utils t)" >> WL-CFG
	fi
}

src_compile() {
	make || die
	make info || die
}

src_install() {
	make \
		LISPDIR=${D}/usr/share/emacs/site-lisp \
		PIXMAPDIR=${D}/usr/share/${PN}/icons \
		install || die

 	elisp-site-file-install ${FILESDIR}/70wl-gentoo.el || die

	dodir /usr/share/${PN}/samples

	insinto /usr/share/${PN}/samples/ja
	doins samples/ja/*
	insinto /usr/share/${PN}/samples/en
	doins samples/en/*

	doinfo doc/wl-ja.info doc/wl.info
	dodoc BUGS* ChangeLog INSTALL* README*
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see /usr/share/doc/${P}/INSTALL.gz."
	einfo "And Sample configuration files exist on /usr/share/${PN}/samples."
}

pkg_postrm() {
	elisp-site-regen
}
