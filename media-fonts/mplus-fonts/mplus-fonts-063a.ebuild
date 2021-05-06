# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

MY_P="mplus-TESTFLIGHT-${PV}"

DESCRIPTION="M+ Japanese outline fonts"
HOMEPAGE="http://mplus-fonts.osdn.jp/"
SRC_URI="mirror://sourceforge.jp/mplus-fonts/62344/${MY_P}.tar.xz"

LICENSE="mplus-fonts"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc x86 ~ppc-macos ~x86-macos"
IUSE=""
RESTRICT="binchecks strip primaryuri"

S="${WORKDIR}/${MY_P}"

FONT_SUFFIX="ttf"
FONT_S="${S}"
DOCS="README_J README_E"
