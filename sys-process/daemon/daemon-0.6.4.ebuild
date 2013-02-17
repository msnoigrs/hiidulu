# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Daemon turns other process into daemons, respawning automatically"
HOMEPAGE="http://www.libslack.org/daemon/"
SRC_URI="http://libslack.org/daemon/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE=""
RESTRICT="test"

DEPEND=""
RDEPEND=""

src_prepare() {
	sed -i -e '/strip/d' rules.mk
}

src_configure() {
	./config
}

src_compile() {
	emake CC="$(tc-getCC)" AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)" \
		CCFLAGS="${CFLAGS}" PREFIX="/usr" || die "emake failed"
}

src_install() {
	emake PREFIX="${D}/usr" install || die "emake install failed"
	dodoc README
}
