# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit font

DESCRIPTION="Noto Sans CJK Language specific fonts"
HOMEPAGE="http://www.google.com/get/noto/cjk.html"
SRC_URI="http://www.google.com/get/noto/pkgs/NotoSansJapanese.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="app-arch/unzip"

FONT_SUFFIX="otf"
FONT_S="${S}"
#FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )
FONTDIR="/usr/share/fonts/${PN}"

# Only installs fonts
RESTRICT="strip bincheckes"

src_unpack() {
	unpack ${A}
	mkdir "${S}"
	mv "${WORKDIR}"/*.otf "${S}"
}
