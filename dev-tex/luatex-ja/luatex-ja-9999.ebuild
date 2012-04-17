# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

EGIT_REPO_URI="git://git.sourceforge.jp/gitroot/luatex-ja/luatexja.git"

inherit git-2

DESCRIPTION="a macro package to typeset Japanese texts using Lua(La)TeX"
HOMEPAGE="http://sourceforge.jp/projects/luatex-ja/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

DEPEND="dev-tex/luatex"
RDEPEND="${DEPEND}"

src_install() {
	luatexjadir="/usr/share/texmf-dist/tex/luatexja"
	dodir ${luatexjadir} || die
	cp -r src/* ${D}${luatexjadir}
	dodoc doc/*.{lua,pdf,tex,dtx,ins}
}

pkg_postinst() {
	einfo "Running mktexlsr..."
	mktexlsr || die "mktexlsr failed"
}

pkg_postrm() {
	einfo "Running mktexlsr..."
	mktexlsr || die "mktexlsr failed"
}
