# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/deprecated/deprecated-2.0.1-r1.ebuild,v 1.5 2010/09/05 16:13:56 armin76 Exp $

EAPI="2"

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="A Ruby library for handling deprecated code"
HOMEPAGE="http://rubyforge.org/projects/deprecated"
SRC_URI="mirror://rubyforge/deprecated/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ~sparc x86"
IUSE="test"

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

each_ruby_test() {
	${RUBY} -Ilib test/deprecated.rb || die "test failed"
}
