# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Maciek Borowka <mborowka@ifaedi.insa-lyon.fr>
# $Header: /var/cvsroot/gentoo-x86/app-misc/kdirstat/kdirstat-2.1.1_beta0.ebuild,v 1.2 2002/05/21 18:14:06 danarmak Exp $

inherit kde-base

DESCRIPTION="KDirStat - nice KDE replacement to du command"
SRC_URI="http://kdirstat.sourceforge.net/download/${PN}-2.1.1-beta.tgz"
HOMEPAGE="http://kdirstat.sourceforge.net/"
S=${WORKDIR}/${PN}-2.1.1-beta

need-kde 3

