# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/kardianos"
GOLANG_PKG_VERSION="c86c10d612bf08e847456ce91d495eb69ad87087"

inherit golang-single

DESCRIPTION="Go vendor tool that works with the standard vendor file."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm"
