# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/catalyst/catalyst-9999.ebuild,v 1.14 2011/06/27 05:04:18 mattst88 Exp $

# catalyst-9999         -> latest Git
# catalyst-VER          -> normal catalyst release

EAPI=2

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/catalyst.git"
	inherit git-2
	SRC_URI=""
	S="${WORKDIR}/${PN}"
	KEYWORDS=""
else
	SRC_URI="mirror://gentoo/${P}.tar.bz2
		http://wolf31o2.org/sources/${PN}/${P}.tar.bz2"
	KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
fi
inherit eutils multilib

DESCRIPTION="release metatool used for creating releases based on Gentoo Linux"
HOMEPAGE="http://www.gentoo.org/proj/en/releng/catalyst/"

LICENSE="GPL-2"
SLOT="0"
RESTRICT=""
IUSE="ccache"

DEPEND=""
RDEPEND="dev-lang/python
	app-crypt/shash
	virtual/cdrtools
	ccache? ( dev-util/ccache )
	ia64? ( sys-fs/dosfstools )
	kernel_linux? ( app-misc/zisofs-tools >=sys-fs/squashfs-tools-2.1 )"

if [[ ${PV} == 9999* ]]; then
	DEPEND="${DEPEND} app-text/asciidoc"
fi

pkg_setup() {
	if use ccache ; then
		einfo "Enabling ccache support for catalyst."
	else
		ewarn "By default, ccache support for catalyst is disabled."
		ewarn "If this is not what you intended,"
		ewarn "then you should add ccache to your USE."
	fi
	echo
	einfo "The template spec files are now installed by default.  You can find"
	einfo "them under /usr/share/doc/${PF}/examples"
	einfo "and they are considered to be the authorative source of information"
	einfo "on catalyst."
	echo
	ewarn "The git master branch (what you get with this -9999 ebuild) for catalyst"
	ewarn "now contains the work-in-progress code for catalyst-3.x. Be aware that"
	ewarn "it's very likely that it will not be in a working state at any given"
	ewarn "point. Please do not file bugs until you have posted on the gentoo-catalyst"
	ewarn "mailing list and we have asked you to do so."
}

src_install() {
	insinto /usr/$(get_libdir)/${PN}
	exeinto /usr/$(get_libdir)/${PN}
	doexe catalyst || die "copying catalyst"
	if [[ ${PV} == 9999* ]]; then
		doins -r modules files || die "copying files"

		# arch files don't live in modules/ in catalyst_2
		[[ ${EGIT_BRANCH} == "catalyst_2" ]] && { doins -r arch || die "copying files"; }
	else
		doins -r arch modules livecd || die "copying files"
	fi
	for x in targets/*; do
		exeinto /usr/$(get_libdir)/${PN}/$x
		doexe $x/* || die "copying ${x}"
	done
	make_wrapper catalyst /usr/$(get_libdir)/${PN}/catalyst
	insinto /etc/catalyst
	doins files/catalyst.conf files/catalystrc || die "copying configuration"
	insinto /usr/share/doc/${PF}/examples
	doins examples/* || die
	dodoc README ChangeLog AUTHORS
	doman files/catalyst.1
	# Here is where we actually enable ccache
	use ccache && \
		dosed 's:options="autoresume kern:options="autoresume ccache kern:' \
		/etc/catalyst/catalyst.conf
	dosed "s:/usr/lib/catalyst:/usr/$(get_libdir)/catalyst:" \
		/etc/catalyst/catalyst.conf
}

pkg_postinst() {
	einfo "You can find more information about catalyst by checking out the"
	einfo "catalyst project page at:"
	einfo "http://www.gentoo.org/proj/en/releng/catalyst/index.xml"
	echo
}
