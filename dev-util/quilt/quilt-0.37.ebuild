# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/quilt/quilt-0.37.ebuild,v 1.3 2005/05/06 11:56:23 ka0ttic Exp $

inherit bash-completion

DESCRIPTION="quilt patch manager"
HOMEPAGE="http://savannah.nongnu.org/projects/quilt"
#SRC_URI="http://savannah.nongnu.org/download/quilt/${P}.tar.gz"
# There are packages hosted at the savannah site, but the maintainers do not
# update them.  Which means we either have to hit the deb package or the suse
# RPM for a current version.
# yuck.
SRC_URI="mirror://debian/pool/main/q/quilt/${P//-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-util/diffstat
	media-gfx/graphviz"

src_unpack() {
	unpack ${A}
	cd ${S}

	# bug 89845
	sed -i "s/ > / '>' /" bash_completion || die "sed bash_completion failed"
}

src_install() {
	make BUILD_ROOT="${D}" install || die "make install failed"

	rm -rf ${D}/usr/share/doc/${P}
	dodoc AUTHORS BUGS quilt.changes doc/README doc/quilt.pdf \
		doc/sample.quiltrc

	rm -rf ${D}/etc/bash_completion.d
	dobashcompletion bash_completion ${PN}
}
