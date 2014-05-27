# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5
inherit font

DESCRIPTION="Mixing mplus and Open Sans"
HOMEPAGE="http://sourceforge.jp/projects/koruri"
SRC_URI="http://jaist.dl.sourceforge.jp/koruri/61152/Koruri-${PV}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="nomirror"

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}/Koruri-${PV}"
FONTDIR="/usr/share/fonts/${PN}"
