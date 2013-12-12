# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="Convert PNG, GIF, TIFF, BMP and XPM images to MS ico format"
HOMEPAGE="http://wizard.ae.krakow.pl/~jb/toico/"
SRC_URI="http://wizard.ae.krakow.pl/~jb/toico/toico-1.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND=">=media-libs/libpng-1.4
	media-libs/tiff
	sys-libs/zlib"
DEPEND="${RDEPEND}"

#src_prepare() {
#	epatch \
#		"${FILESDIR}"/${P}-Makefile.patch \
#		"${FILESDIR}"/${P}-libpng15.patch
#}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
	cp ${PN}.man ${PN}.1
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
}
