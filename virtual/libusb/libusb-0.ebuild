# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/libusb/libusb-0.ebuild,v 1.10 2012/05/06 00:40:32 aballier Exp $

EAPI=2

DESCRIPTION="Virtual for libusb"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND="|| ( >=dev-libs/libusb-0.1.12-r1:0 dev-libs/libusb-compat >=sys-freebsd/freebsd-lib-8.0[usb] )"
