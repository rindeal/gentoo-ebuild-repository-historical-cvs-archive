# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/signing-party/signing-party-1.1.3-r1.ebuild,v 1.1 2010/08/17 00:04:30 robbat2 Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="A collection of several tools related to OpenPGP"
HOMEPAGE="http://pgp-tools.alioth.debian.org/"
SRC_URI="mirror://debian/pool/main/s/signing-party/signing-party_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=app-crypt/gnupg-1.3.92
	dev-perl/GnuPG-Interface
	dev-perl/text-template
	dev-perl/MIME-tools
	>=dev-perl/MailTools-1.62
	virtual/mailx
	virtual/mta
	dev-lang/perl
	|| (
		dev-perl/libintl-perl
		dev-perl/Text-Iconv
		app-text/recode
	)"

src_prepare() {
	# app-crypt/keylookup
	rm -fr keylookup
	# media-gfx/springgraph
	rm -fr springgraph

	sed -i -e "s:/usr/share/doc/signing-party/caff/caffrc.sample:/usr/share/doc/${P}/caff/caffrc.sample.gz:g" caff/caff
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	# Check Makefile when a new tool is introduced to this package.
	# caff
	dobin caff/caff caff/pgp-clean caff/pgp-fixkey
	docinto caff
	dodoc caff/{README*,THANKS,TODO,caffrc.sample}
	# gpgdir
	dobin gpgdir/gpgdir
	docinto gpgdir
	dodoc gpgdir/{VERSION,LICENSE,README,INSTALL,CREDITS,ChangeLog*}
	# gpg-key2ps
	dobin gpg-key2ps/gpg-key2ps
	docinto gpg-key2ps
	dodoc gpg-key2ps/README
	# gpglist
	dobin gpglist/gpglist
	# gpg-mailkeys
	dobin gpg-mailkeys/gpg-mailkeys
	docinto gpg-mailkeys
	dodoc gpg-mailkeys/{example.gpg-mailkeysrc,README}
	# gpgparticipants
	dobin gpgparticipants/gpgparticipants
	# gpgwrap
	dobin gpgwrap/src/gpgwrap
	docinto gpgwrap
	dodoc gpgwrap/{LICENSE,NEWS,README}
	doman gpgwrap/doc/gpgwrap.1
	# gpgsigs
	dobin gpgsigs/gpgsigs
	insinto /usr/share/signing-party
	doins gpgsigs-eps-helper
	# keyanalyze
	# TODO: some of the scripts are intended for webpages, and not really
	# packaging, so they are NOT installed yet.
	dobin keyanalyze/{pgpring/pgpring,keyanalyze,process_keys}
	docinto keyanalyze
	dodoc keyanalyze/{README,ChangeLog}
	# See app-crypt/keylookup instead
	#dobin keylookup/keylookup
	#docinto keylookup 
	#dodoc keylookup/NEWS
	# sig2dot
	dobin sig2dot/sig2dot
	dodoc sig2dot/README.sig2dot
	# See media-gfx/springgraph instead
	#dobin springgraph/springgraph
	#dodoc springgraph/README.springgraph
	# all other manpages, and the root doc
	doman */*.1
	dodoc README
}
