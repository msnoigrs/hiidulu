# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build

EGO_PN="github.com/saibing/bingo/..."

DESCRIPTION="Go language server that speaks Language Server Protocol"
HOMEPAGE="https://github.com/saibing/bingo"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/go-1.11"

src_unpack() {
	mkdir -p "${S}"
	GOPATH="${S}" go get -d -t -u -v -x ${EGO_PN}
	GOPATH="${S}" go get -d -t -u -v -x golang.org/x/tools/go/packages

	pushd "${S}/src/${EGO_PN%/...}" || die
	GO111MODULE=on GOPATH="${S}" GOCACHE="${T}/go-cache" go build -v
	popd || die
}

src_compile() {
	pushd "${S}/src/${EGO_PN%/...}" || die
	GO111MODULE=on GOPATH="${S}" GOCACHE="${T}/go-cache" go build -v
	popd || die
}

src_install() {
	pushd "${S}/src/${EGO_PN%/...}" || die
	dobin bingo
	popd || die
}
