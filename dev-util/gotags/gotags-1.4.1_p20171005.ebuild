# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/jstemmer"
GOLANG_PKG_VERSION="f83c8855fab240afcae2524ca24be4c7656f5b98"
GOLANG_PKG_HAVE_TEST=1

inherit golang-single

DESCRIPTION="ctags-compatible tag generator for Go"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"

COMMON_DEP="x11-libs/libX11"
DEPEND="${COMMON_DEP}"
RDEPEND="${COMMON_DEP}
	media-gfx/byzanz
	x11-misc/xdotool
	x11-apps/xprop
	x11-apps/xwininfo"
