# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/lua-mode/lua-mode-20071122.ebuild,v 1.9 2009/07/02 17:08:35 jer Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing Lua scripts"
HOMEPAGE="http://lua-users.org/wiki/LuaEditorSupport"
SRC_URI="http://luaforge.net/frs/download.php/2724/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ~s390 ~sh ~sparc x86"
IUSE=""

SITEFILE="70${PN}-gentoo.el"

S="${WORKDIR}"
