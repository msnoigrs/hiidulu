# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit font

DESCRIPTION="Japanese TrueType font for coding"
HOMEPAGE="http://github.com/tomokuni/Myrica"
SRC_URI="https://github.com/tomokuni/Myrica/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="mplus-fonts Apache-2.0 OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

# Only installs fonts
RESTRICT="binchecks strip"

S="${WORKDIR}/Myrica-${PV}"
FONT_S="${S}"
FONT_SUFFIX="TTC"
DOCS="README*"
