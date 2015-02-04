# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit font

SRC_PREFIX="mirror://sourceforge.jp/users/7"

DESCRIPTION="Mgen+ Japanese outline fonts"
HOMEPAGE="http://jikasei.me/font/mgenplus/"
SRC_URI="${SRC_PREFIX}/7783/mgenplus-${PV}.7z"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~x86 ~ppc-macos ~x86-macos"
IUSE=""
RESTRICT="binchecks strip"

DEPEND="app-arch/p7zip"
RDEPEND=""
S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"
DOCS=( README_MgenPlus.txt )
