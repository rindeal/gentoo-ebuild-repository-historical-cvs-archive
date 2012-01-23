# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/syb/syb-0.3.6.ebuild,v 1.1 2012/01/23 13:28:42 gienah Exp $

# ebuild generated by hackport 0.2.13

EAPI="3"

# PDEPEND of ghc, so restrict depgraph
CABAL_FEATURES="lib profile nocabaldep"
inherit base haskell-cabal

DESCRIPTION="Scrap Your Boilerplate"
HOMEPAGE="http://www.cs.uu.nl/wiki/GenericProgramming/SYB"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="test"

RDEPEND=">=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}"
