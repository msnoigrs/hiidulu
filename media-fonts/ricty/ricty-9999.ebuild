# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

MIG_SFD="63545"
MIG_V="20150712"
MIG="redir.php?m=iij&f=%2Fmix-mplus-ipa%2F${MIG_SFD}%2Fmigu-1m-${MIG_V}.zip"

DESCRIPTION="Japanese TrueType font. for programing"
HOMEPAGE="http://www.rs.tus.ac.jp/yyusa/ricty.html"
SRC_URI="https://github.com/cyrealtype/Inconsolata/blob/master/fonts/ttf/Inconsolata-Regular.ttf
	https://github.com/cyrealtype/Inconsolata/blob/master/fonts/ttf/Inconsolata-Bold.ttf
	http://www.rs.tus.ac.jp/yyusa/ricty/ricty_generator.sh
	http://sourceforge.jp/frs/${MIG}"

# M+ FONTS -> mplus-fonts
# IPAGothic -> IPAfont
LICENSE="mplus-fonts IPAfont OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="media-gfx/fontforge"

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"
FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )
FONTDIR="/usr/share/fonts/${PN}"

# Only installs fonts
RESTRICT="strip bincheckes"

src_unpack() {
	cd ${S}
	unpack ${MIG}
	cp "${DISTDIR}/Inconsolata-Regular.ttf" "${DISTDIR}/Inconsolata-Bold.ttf" .
	cp "${DISTDIR}/ricty_generator.sh" .
}

src_compile() {
	sh ricty_generator.sh -l Inconsolata-Regular.ttf Inconsolata-Bold.ttf migu-1m-${MIG_V}/migu-1m-regular.ttf migu-1m-${MIG_V}/migu-1m-bold.ttf
}
