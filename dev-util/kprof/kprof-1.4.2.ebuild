# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kprof/kprof-1.4.2.ebuild,v 1.7 2004/03/13 01:49:46 mr_bones_ Exp $

inherit kde
need-kde 3

DESCRIPTION="A KDE3 visual tool helping developers to analyze the profiling results generated by code profilers."
HOMEPAGE="http://kprof.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_unpack() {
	base_src_unpack
	# Rename the source directory to include the version to make the eclass happy
	mv ${WORKDIR}/${PN} ${WORKDIR}/${P}
}
