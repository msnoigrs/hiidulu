# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit font

MY_SFD="56156"

MIGMIX_URI_BASE="mirror://sourceforge.jp/mix-mplus-ipa/"
DESCRIPTION="Japanese TrueType font. MigMix"
HOMEPAGE="http://mix-mplus-ipa.sourceforge.jp/migmix/"
SRC_URI="http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fmix-mplus-ipa%2F${MY_SFD}%2Fmigu-1c-${PV}-2.zip
	http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fmix-mplus-ipa%2F${MY_SFD}%2Fmigu-1m-${PV}-2.zip
	http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fmix-mplus-ipa%2F${MY_SFD}%2Fmigu-1p-${PV}-2.zip
	http://sourceforge.jp/frs/redir.php?m=iij&f=%2Fmix-mplus-ipa%2F${MY_SFD}%2Fmigu-2m-${PV}-2.zip"

# M+ FONTS -> mplus-fonts
# IPAGothic -> IPAfont
LICENSE="mplus-fonts IPAfont Apache-2.0 BitstreamVera"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="app-arch/unzip"

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"
FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )
FONTDIR="/usr/share/fonts/${PN}"
#DOCS="Changelog README*"

# Only installs fonts
RESTRICT="strip bincheckes"

src_unpack() {
	unpack ${A}
	mv ${S}/*/*.ttf .
}
