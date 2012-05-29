# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/haskell-src-exts/haskell-src-exts-1.13.3.ebuild,v 1.1 2012/05/29 09:53:56 gienah Exp $

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Manipulating Haskell source: abstract syntax, lexer, parser, and pretty-printer"
HOMEPAGE="http://code.haskell.org/haskell-src-exts"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-haskell/cpphs-1.3
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6
		dev-haskell/happy"

src_prepare() {
	# test suite is broken, expects the package to be already installed.
	# this new Setup.hs will use the package inplice for tests
	cp "${FILESDIR}/haskell-src-exts-1.10.2-Setup.hs" "${S}/Setup.hs" \
		|| die "Could not cp Setup.hs for tests"

	# remove broken tests. they will fail if you expect them to pass, and pass
	# if you expect them to fail...
	rm "${S}/Test/examples/Unicode"{.hs,Syntax.hs} \
		|| die "Could not rm broken tests"
}
