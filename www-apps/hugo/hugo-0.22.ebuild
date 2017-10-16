# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/spf13"
GOLANG_PKG_VERSION="e797a94d975d23a04dd0089f7db2c93ba93c43fb"

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
