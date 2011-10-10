# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

MIGMIX_URI_BASE="mirror://sourceforge.jp/mix-mplus-ipa/"
DESCRIPTION="Japanese TrueType font. MigMix"
HOMEPAGE="http://mix-mplus-ipa.sourceforge.jp/migmix/"
SRC_URI="http://sourceforge.jp/frs/redir.php?m=keihanna&f=%2Fmix-mplus-ipa%2F50858%2FMigMix-1M-20110207.zip
	http://sourceforge.jp/frs/redir.php?m=keihanna&f=%2Fmix-mplus-ipa%2F50858%2FMigMix-1P-20110207.zip
	http://sourceforge.jp/frs/redir.php?m=globalbase&f=%2Fmix-mplus-ipa%2F50858%2FMigMix-2M-20110207.zip
	http://sourceforge.jp/frs/redir.php?m=keihanna&f=%2Fmix-mplus-ipa%2F50858%2FMigMix-2P-20110207.zip"

# M+ FONTS -> mplus-fonts
# IPAGothic -> IPAfont
LICENSE="mplus-fonts IPAfont"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="app-arch/unzip"

#S="${WORKDIR}/VLGothic"

FONT_SUFFIX="ttf"
FONT_S="${S}"
FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )
FONTDIR="/usr/share/fonts/${PN}"
#DOCS="Changelog README*"

# Only installs fonts
RESTRICT="strip bincheckes"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	mv ${S}/*/*.ttf .
}
