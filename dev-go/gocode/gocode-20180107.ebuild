# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/nsf"
GOLANG_PKG_VERSION="416643789f088aa5077f667cecde7f966131f6be"
GOLANG_PKG_HAVE_TEST=1

inherit golang-single

DESCRIPTION="An autocompletion daemon for the Go programming language"
HOMEPAGE="https://github.com/nsf/gocode"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-fbsd ~x86-fbsd"
