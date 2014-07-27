# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

EGIT_REPO_URI="https://code.google.com/p/noto/"

inherit font git-2

DESCRIPTION="Noto Sans CJK Language specific fonts"
HOMEPAGE="http://www.google.com/get/noto/cjk.html"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

FONT_SUFFIX="otf"
FONT_S="${S}/third_party/noto_cjk"
#FONT_CONF=( "${FILESDIR}/66-${PN}.conf" )
FONTDIR="/usr/share/fonts/${PN}"

# Only installs fonts
RESTRICT="strip bincheckes"

src_unpack() {
	git-2_src_unpack
	rm "${FONT_S}"/NotoSans*-Windows.otf
	rm "${FONT_S}"/NotoSansKR*
	rm "${FONT_S}"/NotoSansHant*
	rm "${FONT_S}"/NotoSansCJK*
	rm "${FONT_S}"/NotoSansJP*
}
