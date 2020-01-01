# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5
inherit font

MY_P="Cica_v${PV}_with_emoji"
DESCRIPTION="Cica font"
HOMEPAGE="https://github.com/miiton/Cica"
SRC_URI="https://github.com/miiton/Cica/releases/download/v${PV}/${MY_P}.zip"

LICENSE="MIT Apache-2.0 OFL-1.1 BitstreamVera"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="nomirror"

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"
FONTDIR="/usr/share/fonts/${PN}"
