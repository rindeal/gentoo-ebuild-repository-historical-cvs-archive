# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/kramdown/kramdown-0.13.6.ebuild,v 1.2 2012/05/12 06:40:50 a3li Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18 jruby"

RAKE_FAKEGEM_DOCDIR="htmldoc/rdoc"
RUBY_FAKEGEM_EXTRADOC="README ChangeLog"

RUBY_FAKEGEM_EXTRAINSTALL="data"

inherit ruby-fakegem

DESCRIPTION="yet-another-markdown-parser but fast, pure Ruby, using a strict syntax definition."
HOMEPAGE="http://kramdown.rubyforge.org/"

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="latex"

RDEPEND+="latex? ( dev-texlive/texlive-latex dev-texlive/texlive-latexextra )"

ruby_add_bdepend "doc? ( dev-ruby/rdoc )
	test? ( >=dev-ruby/coderay-1.0.0 )"

all_ruby_prepare() {
	if ! use latex; then
		# Remove latex tests. They will fail gracefully when latex isn't
		# present at all, but not when components are missing (most
		# notable ucs.sty).
		sed -i -e '/latex -v/,/^  end/ s:^:#:' test/test_files.rb || die
	fi
}

all_ruby_compile() {
	if use doc; then
		rdoc-2 -o htmldoc/rdoc --main README --title kramdown lib README || die "Unable to generate documentation"
	fi
}

all_ruby_install() {
	all_fakegem_install

	doman man/man1/kramdown.1
}
