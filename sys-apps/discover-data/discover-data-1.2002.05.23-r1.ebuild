# (C) 2002 The TelemetryBox Corporation. http://telemetrybox.biz
# Distributed under the terms of the GNU General Public License v2
# Christoph Lameter, <christoph@lameter.com>, July 15, 2002
# $Header: /var/cvsroot/gentoo-x86/sys-apps/discover-data/discover-data-1.2002.05.23-r1.ebuild,v 1.7 2003/09/19 05:45:16 seemant Exp $

S=${WORKDIR}/discover-data-${P}-1
DESCRIPTION="data for discover. list of pci ids. pnp ids etc."
HOMEPAGE="http://hackers.progeny.com/discover/"
SRC_URI="ftp://ftp.debian.org/debian/pool/main/d/discover-data/${PN}_${PV}-1.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc sparc ~alpha ~hppa ~mips ~arm"

DEPEND="sys-apps/tar sys-apps/gzip"

src_compile() {
	patch -p0 <${FILESDIR}/kernel-2.2-2.4.drivername.patch
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog
}
