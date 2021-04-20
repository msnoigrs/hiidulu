# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=7
inherit font

MY_P="Koruri-${PV}"
DESCRIPTION="Mixing mplus and Open Sans"
HOMEPAGE="https://koruri.github.io/"
SRC_URI="https://github.com/Koruri/Koruri/releases/download/Koruri-${PV}/Koruri-${PV}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="nomirror"

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}/Koruri-${PV}"
FONTDIR="/usr/share/fonts/${PN}"
