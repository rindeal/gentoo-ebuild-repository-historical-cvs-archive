# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/locateopen/locateopen-0.8.0.ebuild,v 1.11 2005/01/01 16:51:57 eradicator Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: open a file without supplying a path"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=858"
LICENSE="vim"
KEYWORDS="sparc x86 alpha ia64 mips ~ppc ~amd64"
IUSE=""

RDEPEND="${RDEPEND} sys-apps/slocate"

VIM_PLUGIN_HELPTEXT=\
"This plugin provides commands which hook vim into slocate:
\    :LocateEdit filename
\    :LocateSplit filename
\    :LocateSource filename
To configure:
\    :let g:locateopen_ignorecase = 1    \" enable ignore case mode
\    :let g:locateopen_smartcase = 0     \" disable smart case mode
\    :let g:locateopen_alwaysprompt = 1  \" show menu for one match"
