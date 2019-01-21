# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5
inherit font

MY_P="Koruri-${PV}"
DESCRIPTION="Mixing mplus and Open Sans"
HOMEPAGE="http://sourceforge.jp/projects/koruri"
SRC_URI="mirror://sourceforge.jp/${PN}/70038/${MY_P}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="nomirror"

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}/Koruri-${PV}"
FONTDIR="/usr/share/fonts/${PN}"
