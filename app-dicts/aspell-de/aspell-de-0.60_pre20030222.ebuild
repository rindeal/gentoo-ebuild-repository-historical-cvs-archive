# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-de/aspell-de-0.60_pre20030222.ebuild,v 1.3 2005/02/20 10:17:40 arj Exp $

ASPELL_LANG="German and Swiss-German"

ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

FILENAME=aspell6-de-20030222-1

SRC_URI="ftp://ftp.gnu.org/gnu/aspell/dict/de/${FILENAME}.tar.bz2"
S=${WORKDIR}/${FILENAME}

