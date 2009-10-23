# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-activeldap/ruby-activeldap-1.2.0.ebuild,v 1.1 2009/10/23 14:35:42 graaff Exp $

inherit ruby gems

MY_P="${P/ruby-//}"
DESCRIPTION="Ruby/ActiveLDAP provides an activerecord inspired object oriented interface to LDAP"
HOMEPAGE="http://ruby-activeldap.rubyforge.org/doc/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
USE_RUBY="ruby18"

DEPEND="
	=dev-ruby/activerecord-2.3.4
	=dev-ruby/locale-2.0.4
	=dev-ruby/ruby-gettext-2.0.4
	=dev-ruby/gettext_activerecord-2.0.4
	>=dev-ruby/ruby-ldap-0.8.2"
RDEPEND="${DEPEND}"
