# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/test-framework/test-framework-0.4.2.0.ebuild,v 1.1 2012/01/22 14:19:16 gienah Exp $

# ebuild generated by hackport 0.2.14

EAPI="3"

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Framework for running and organising tests, with HUnit and QuickCheck support"
HOMEPAGE="http://batterseapower.github.com/test-framework/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/ansi-terminal-0.4.0
		>=dev-haskell/ansi-wl-pprint-0.5.1
		>=dev-haskell/hostname-1.0
		>=dev-haskell/regex-posix-0.72
		>=dev-haskell/time-1.1.2
		>=dev-haskell/xml-1.3.5
		>=dev-lang/ghc-6.10.4"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.3"
