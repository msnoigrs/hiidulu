# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit font

DESCRIPTION="Noto Sans CJK in OTC"
HOMEPAGE="http://www.google.com/get/noto/cjk.html"
SRC_URI="https://noto.googlecode.com/archive/5331bd09edd0df8b4b0f105fd2cd77fcb6966f0d.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="app-arch/unzip"

S="${WORKDIR}/noto-5331bd09edd0/third_party/noto_cjk"

FONT_SUFFIX="ttc"
FONT_S="${S}"
#FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )
FONTDIR="/usr/share/fonts/${PN}"

# Only installs fonts
RESTRICT="strip bincheckes"

#src_unpack() {
#	unpack ${A}
#	mkdir "${S}"
#	mv "${WORKDIR}"/*.ttc "${S}"
#}
