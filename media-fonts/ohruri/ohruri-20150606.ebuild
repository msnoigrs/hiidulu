# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit font

MY_P="Ohruri-${PV}"
DESCRIPTION="Japanese TrueType font based on M+, Source Han Sans and Open Sans"
HOMEPAGE="http://github.com/Koruri/Ohruri"
SRC_URI="https://github.com/Koruri/Ohruri/archive/${MY_P}.tar.gz"

LICENSE="mplus-fonts Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

# Only installs fonts
RESTRICT="binchecks strip"

S="${WORKDIR}/Ohruri-${MY_P}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
DOCS="README*"
