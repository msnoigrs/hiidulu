# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

EGIT_REPO_URI="https://code.google.com/p/noto/"

inherit font

DESCRIPTION="Noto Sans CJK Multilingual fonts in OTF"
HOMEPAGE="http://www.google.com/get/noto/cjk.html"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="app-arch/unzip"

S="${WORKDIR}/noto-5331bd09edd0/third_party/noto_cjk"

FONT_SUFFIX="otf"
FONT_S="${S}/third_party/noto_cjk"
#FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )
FONTDIR="/usr/share/fonts/${PN}"

# Only installs fonts
RESTRICT="strip bincheckes"

#src_unpack() {
#	unpack ${A}
#	mkdir "${S}"
#	mv "${WORKDIR}"/*.ttc "${S}"
#}
