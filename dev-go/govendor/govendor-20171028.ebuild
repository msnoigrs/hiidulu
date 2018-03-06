# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/kardianos"
GOLANG_PKG_VERSION="f60bcdf2e61a16899c2bd0c793d5914842034455"

inherit golang-single

DESCRIPTION="Go vendor tool that works with the standard vendor file."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm"
