# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faac/gst-plugins-faac-0.10.19.ebuild,v 1.2 2010/12/20 12:40:54 tomka Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="media-libs/faac
	>=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}"
