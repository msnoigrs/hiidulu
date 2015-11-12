# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A Perl script to synchronize a local directory tree and a remote FTP directory tree."
HOMEPAGE="http://ftpsync.sourceforge.net/"
MY_TARBALL="ftpsync-1.3.03.tar.bz2"
SRC_URI="http://osdn.jp/frs/chamber_redir.php?m=iij&f=%2Fusers%2F9%2F9549%2F${MY_TARBALL} -> ${MY_TARBALL}"

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
