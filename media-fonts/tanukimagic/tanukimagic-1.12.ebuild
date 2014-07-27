# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

DESCRIPTION="Japanese TrueType font. Tanuki Magic"
HOMEPAGE="http://tanukifont.com/"
SRC_URI="http://tanukifont.com/download/TanukiMagic_1_12.zip"

LICENSE="freedist" # TODO
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="app-arch/unzip"

S="${WORKDIR}/TanukiMagic_1_12"

FONT_SUFFIX="ttf"
FONT_S="${S}"
#FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )
FONTDIR="/usr/share/fonts/${PN}"
DOCS="readme-utf8.txt"

# Only installs fonts
RESTRICT="strip bincheckes"

src_unpack() {
	unpack ${A}
	cd ${S}
	iconv -f cp932 -t utf8 readme.txt > readme-utf8.txt
}
