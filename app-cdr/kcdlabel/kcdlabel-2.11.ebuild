# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kcdlabel/kcdlabel-2.11.ebuild,v 1.5 2004/03/14 17:20:17 mr_bones_ Exp $

inherit kde
need-kde 3

S=${WORKDIR}/${P}-KDE3
DESCRIPTION="cd label printing tool for kde"
HOMEPAGE="http://kcdlabel.sourceforge.net/"
SRC_URI="http://kcdlabel.sourceforge.net/download/${P}-KDE3.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
