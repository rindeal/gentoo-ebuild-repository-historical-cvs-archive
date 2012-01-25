# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ffmpegthumbs/ffmpegthumbs-4.8.0.ebuild,v 1.1 2012/01/25 18:17:19 johu Exp $

EAPI=4

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="A FFmpeg based thumbnail Generator for Video Files."
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	virtual/ffmpeg
"
RDEPEND="${DEPEND}"
