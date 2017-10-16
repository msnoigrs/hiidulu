# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/spf13"
GOLANG_PKG_VERSION="524c67107aa058b314a4437858a1d41bfd6b0dc2"

inherit golang-common

DESCRIPTION="A Fast and Flexible Static Site GeneratoroLang"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm"

DEPEND="dev-go/govendor"

src_unpack() {
	golang_setup
	govendor get github.com/spf13/hugo
}
