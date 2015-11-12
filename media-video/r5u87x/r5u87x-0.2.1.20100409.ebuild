# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs

DESCRIPTION="r5u87x userspace firmware loader"
HOMEPAGE="http://www.bitbucket.org/ahixon/r5u87x/"
MY_TARBALL="r5u87x-0.2.1.20100409.tar.bz2"
SRC_URI="http://osdn.jp/frs/chamber_redir.php?m=iij&f=%2Fusers%2F9%2F9546%2F${MY_TARBALL} -> ${MY_TARBALL}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/glib:2
	virtual/libusb:0
	!media-video/r5u870"
RDEPEND=""

src_prepare() {
	sed -e "s#\(^PREFIX=\).*#\1${PREFIX}#" \
		-e "s#\(^libdir=/\).*#\1$(get_libdir)#" \
		-e "s#\(^firmdir=.*\/\)r5u87x/ucode#\1firmware#" \
		-i Makefile || die "Fixing Makefile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
}

pkg_postinst() {
	einfo "Reloading firmware if necessary..."
	"${PREFIX}/sbin/r5u87x-loader" --reload
}
