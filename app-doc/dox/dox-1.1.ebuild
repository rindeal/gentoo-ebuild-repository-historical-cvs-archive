# Copyright 2001-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Enrico Morelli - 16/06/2002
# $Header: /var/cvsroot/gentoo-x86/app-doc/dox/dox-1.1.ebuild,v 1.1 2002/06/21 22:38:05 rphillips Exp $

DESCRIPTION="Dox is a graphical documentation browser for Unix/X11."
SRC_URI="http://download.berlios.de/dox/${P}.tar.gz"
HOMEPAGE="http://dox.beriols.de"
RDEPEND=">=x11-libs/qt-3"
DEPEND="net-www/htdig"

S=${WORKDIR}/${P}

src_unpack() {

	unpack ${A}
	cd ${S}
	cp configure configure.new
	cat configure | sed -e 's:/opt/www/htdig/bin/htdig:/usr/bin/htdig:g' \
	-e 's:/opt/www/htdig/bin/htmerge:/usr/bin/htmerge:g' \
	-e 's:/opt/www/cgi-bin/htsearch:/home/httpd/cgi-bin/htsearch:g' > configure.new
	mv configure.new configure
    
}

src_compile()
{


	./configure  -prefix /usr || die
	make all || die
	mv stl/stl.toc stl/STL.toc
	mv stl/stl.index stl/STL.index
	mv data/perl.toc data/Perl.toc
	

}

src_install()
{

	PREFIX="/usr/share/dox"
	into /usr
	dobin dox/dox man2html/dox-man2html info2html/dox-info2html tags2dox/dox-tags2dox htdig/dox-htdig
	insinto ${PREFIX}/scripts
	insopts -m 0755
	doins pydoc2html/dox_pydoc.py pydoc2html/dox_inspect.py 
	insinto ${PREFIX}/htdig
	doins data/wrapper.html data/nomatch.html  data/syntax.html data/star.png data/star_blank.png data/bad_words
	insinto ${PREFIX}/html/libc
	doins libc/*.html 
	insinto ${PREFIX}/tocs
	doins libc/libc.toc stl/STL.toc data/Perl.toc
	insinto ${PREFIX}/indices
	doins libc/libc.index stl/STL.index
	insinto ${PREFIX}/html/stl
	doins stl/*.html  stl/*.gif 
	doman data/dox.1 data/dox.5 data/dox-man2html.1 data/dox-info2html.1 data/dox-tags2dox.1 data/dox-htdig.1
	
}
