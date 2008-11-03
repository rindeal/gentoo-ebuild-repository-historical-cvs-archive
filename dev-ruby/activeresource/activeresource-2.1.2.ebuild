# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activeresource/activeresource-2.1.2.ebuild,v 1.3 2008/11/03 22:21:14 maekke Exp $

inherit ruby gems

DESCRIPTION="Think Active Record for web resources.."
HOMEPAGE="http://rubyforge.org/projects/activeresource/"

LICENSE="MIT"
SLOT="2.1"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.5
	~dev-ruby/activesupport-2.1.2"
