# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="A Perl script to synchronize a local directory tree and a remote FTP directory tree."
HOMEPAGE="http://ftpsync.sourceforge.net/"
SRC_URI="http://dev.gentoo.gr.jp/~igarashi/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/libwww-perl"

src_install() {
	dodoc doc/README
	dobin src/ftpsync.pl
}
