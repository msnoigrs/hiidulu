# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit font

DESCRIPTION="Japanese TrueType font. Koku Mincho Gothic"
HOMEPAGE="http://freefonts.jp/"
SRC_URI="http://freefonts.jp/dl_c62xbza7jt/ki_kokumin.zip
	http://freefonts.jp/dl_c62xbza7jt/ki_kokugo.zip"
# IPAMincho -> IPAfont
LICENSE="IPAfont"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="app-arch/unzip"

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"
#FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )
FONTDIR="/usr/share/fonts/${PN}"
#DOCS="Changelog README*"

# Only installs fonts
RESTRICT="strip bincheckes"

src_unpack() {
	unpack ${A}
#	rm "${S}"/*.ttf
	mv "${S}"/ki_kokugo/font_1_kokugl_1.00_rls.ttf "${S}"
	mv "${S}"/ki_kokumin/font_1_kokumr_1.00_rls.ttf "${S}"
}
