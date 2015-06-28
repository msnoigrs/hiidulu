# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

#EGIT_REPO_URI="git://git.sourceforge.jp/gitroot/luatex-ja/luatexja.git"
EGIT_REPO_URI="git://git.osdn.jp/gitroot/luatex-ja/luatexja.git"
#EGIT_COMMIT="a2678b42" # 20150420.0
#EGIT_COMMIT="beef40dd"
EGIT_COMMIT="fed2ae04"
#EGIT_COMMIT="b94a4a89" # 20150307.0

inherit git-2

DESCRIPTION="a macro package to typeset Japanese texts using Lua(La)TeX"
HOMEPAGE="http://sourceforge.jp/projects/luatex-ja/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

DEPEND="|| ( >=app-text/texlive-core-2014-r2
			dev-tex/luatex )"
RDEPEND="${DEPEND}"

src_install() {
	luatexjadir="/usr/share/texmf-site/tex/luatex/luatexja"
	dodir ${luatexjadir} || die
	cp -r src/* ${D}${luatexjadir}
	dodoc doc/*.{lua,pdf,dtx,ins}
}

pkg_postinst() {
	einfo "Running mktexlsr..."
	mktexlsr || die "mktexlsr failed"
}

pkg_postrm() {
	einfo "Running mktexlsr..."
	mktexlsr || die "mktexlsr failed"
}
