# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit font

DESCRIPTION="Japanese TrueType font. Logo Type Gothic"
HOMEPAGE="http://www.fontna.com/blog/1226/
	http://www.fontna.com/blog/1345/"
#SRC_URI="http://flop.sakura.ne.jp/font/LogoTypeGothic.zip
#		http://flop.sakura.ne.jp/font/LogoTypeGothicCondense.zip"
SRC_URI="LogoTypeGothic.zip LogoTypeGothicCondense.zip"

# M+ FONTS -> mplus-fonts
# IPAGothic -> IPAfont
LICENSE="mplus-fonts"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="app-arch/unzip"

S="${WORKDIR}"

FONT_SUFFIX="otf"
FONT_S="${S}"
#FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )
FONTDIR="/usr/share/fonts/${PN}"
#DOCS="Changelog README*"

# Only installs fonts
RESTRICT="strip bincheckes"

src_unpack() {
	unpack ${A}
	mv LogoTypeGothic/*.otf LogoTypeGothic.otf
	mv LogoTypeGothicCondense/*.otf LogoTypeGothicCondense.otf
}
