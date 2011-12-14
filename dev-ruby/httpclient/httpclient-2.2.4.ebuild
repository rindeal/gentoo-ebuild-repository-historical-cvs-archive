# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/httpclient/httpclient-2.2.4.ebuild,v 1.2 2011/12/14 18:49:16 graaff Exp $

EAPI=4

USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="-Ilib test"
RUBY_FAKEGEM_TASK_DOC="doc"

RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="README.txt"

inherit ruby-fakegem

DESCRIPTION="'httpclient' gives something like the functionality of libwww-perl (LWP) in Ruby"
HOMEPAGE="https://github.com/nahi/httpclient"
SRC_URI="https://github.com/nahi/httpclient/tarball/v${PV} -> ${P}.tgz"
RUBY_S="nahi-httpclient-*"

LICENSE="Ruby"
SLOT="0"

KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="${RDEPEND}
	!dev-ruby/http-access2"

ruby_add_rdepend "virtual/ruby-ssl"

ruby_add_bdepend "doc? ( dev-ruby/rdoc )"

all_ruby_prepare () {
	rm Gemfile || die
	sed -i -e '/[bB]undler/s:^:#:' Rakefile || die
}

each_ruby_prepare() {
	# Don't run two tests that are known to fail with jruby. This is a
	# bug in jruby that won't be fixed until jruby 1.7.
	# https://github.com/nahi/httpclient/issues/61
	case ${RUBY} in
		*jruby)
			sed -i -e '/test_get_gzipped_content/,/end/s:^:#:' \
				-e '/test_socket_local/,/^  end/s:^:#:' \
				test/test_httpclient.rb
			;;
		*)
			;;
	esac
}

each_ruby_test() {
	${RUBY} -Ilib -S testrb test/test_*.rb || die
}
