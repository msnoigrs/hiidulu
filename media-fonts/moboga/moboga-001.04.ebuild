# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit font

DESCRIPTION="Japanese TrueType font. MoboGothic MogaGothic MogaMincho"
HOMEPAGE="http://yozvox.web.fc2.com/82A882B782B782DF8374834883938367.html"
SRC_URI="http://yozvox.web.fc2.com/MoBoGa.7z"

# M+ FONTS -> mplus-fonts
# IPAGothic IPAMincho -> IPAfont
LICENSE="mplus-fonts IPAfont"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="app-arch/p7zip"

S="${WORKDIR}/MoBoGa"

FONT_SUFFIX="ttf"
FONT_S="${S}"
FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )
FONTDIR="/usr/share/fonts/${PN}"
#DOCS="Changelog README*"

# Only installs fonts
RESTRICT="strip bincheckes"

src_unpack() {
	unpack ${A}
#	mv ${S}/*/*.ttf .
}
