# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pnetlib/pnetlib-0.6.6.ebuild,v 1.6 2004/06/29 14:38:50 vapier Exp $

DESCRIPTION="Portable .NET C# library"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu/pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64"
IUSE="X"

DEPEND="=dev-dotnet/pnet-${PV}*
	X? ( virtual/x11 )"

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog HACKING INSTALL NEWS README
	dodoc doc/*.txt
	dohtml doc/*.html
}
