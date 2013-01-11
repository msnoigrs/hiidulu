# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

EGIT_REPO_URI="git://github.com/yascentur/Ricty.git"

inherit font git-2

MIG_SFD="57240"
MIG_V="20121030"
MIG="redir.php?m=iij&f=%2Fmix-mplus-ipa%2F${MIG_SFD}%2Fmigu-1m-${MIG_V}.zip"

DESCRIPTION="Japanese TrueType font. for programing"
HOMEPAGE="http://save.sys.t.u-tokyo.ac.jp/~yusa/fonts/ricty.thml"
#SRC_URI="http://save.sys.t.u-tokyo.ac.jp/~yusa/fonts/ricty/Ricty-${PV}.tar.gz"
SRC_URI="http://levien.com/type/myfonts/Inconsolata.otf
	http://sourceforge.jp/frs/${MIG}"

# M+ FONTS -> mplus-fonts
# IPAGothic -> IPAfont
LICENSE="mplus-fonts IPAfont OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="media-gfx/fontforge"

FONT_SUFFIX="ttf"
FONT_S="${S}"
FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )
FONTDIR="/usr/share/fonts/${PN}"
#DOCS="Changelog README*"

# Only installs fonts
RESTRICT="strip bincheckes"

src_unpack() {
	git-2_src_unpack
	cd ${S}
	unpack ${MIG}
	cp "${DISTDIR}/Inconsolata.otf" .
}

src_compile() {
	sh ricty_generator.sh Inconsolata.otf migu-1m-${MIG_V}/migu-1m-regular.ttf migu-1m-${MIG_V}/migu-1m-bold.ttf
}
