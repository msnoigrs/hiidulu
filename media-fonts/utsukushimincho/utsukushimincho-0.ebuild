# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit font

DESCRIPTION="Japanese OpenType font. Utsukushi Mincho old"
HOMEPAGE="http://www.flopdesign.com/freefont/utsukushi-mincho-font.html"
SRC_URI="http://www.flopdesign.com/images/datafont/UtsukushiMincho_FONT.zip"

# IPAMincho -> IPAfont
LICENSE="IPAfont"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="app-arch/unzip"

S="${WORKDIR}/UtsukushiMincho_FONT"

FONT_SUFFIX="otf"
FONT_S="${S}"
#FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )
FONTDIR="/usr/share/fonts/${PN}"
#DOCS="Changelog README*"

# Only installs fonts
RESTRICT="strip bincheckes"
