# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit font

DESCRIPTION="Japanese TrueType font for coding"
HOMEPAGE="http://github.com/tomokuni/Myrica"
SRC_URI="https://github.com/tomokuni/Myrica/raw/master/product/Myrica.7z -> Myrica-${PV}.7z
https://github.com/tomokuni/Myrica/raw/master/product/MyricaM.7z -> MyricaM-${PV}.7z"

LICENSE="mplus-fonts Apache-2.0 OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

# Only installs fonts
RESTRICT="binchecks strip"

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="TTC"
DOCS="README*"
