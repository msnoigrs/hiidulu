# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/spf13"
#GOLANG_PKG_VERSION="e797a94d975d23a04dd0089f7db2c93ba93c43fb"

inherit golang-common

DESCRIPTION="A Fast and Flexible Static Site GeneratoroLang"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm"

DEPEND="dev-go/govendor"
RDEPEND="dev-python/pygments"

src_unpack() {
	golang_setup

	mkdir -p "${S%/*}" || die

	govendor get github.com/spf13/hugo
}

src_prepare() {
	golang-common_src_prepare
}

src_confirugre() {
	golang-common_src_configure
}

src_compile() {
	golang-common_src_compile
}

src_install() {
	golang-common_src_install
}

src_test() {
	golang-common_src_test
}
