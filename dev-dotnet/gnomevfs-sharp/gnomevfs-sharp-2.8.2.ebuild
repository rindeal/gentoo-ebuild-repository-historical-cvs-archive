# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gnomevfs-sharp/gnomevfs-sharp-2.8.2.ebuild,v 1.2 2006/07/24 01:12:06 tester Exp $

inherit gtk-sharp-component

SLOT="2"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

DEPEND="${DEPEND}
		>=gnome-base/gnome-vfs-2.10"

GTK_SHARP_COMPONENT_SLOT="2"
GTK_SHARP_COMPONENT_SLOT_DEC="-2.0"
