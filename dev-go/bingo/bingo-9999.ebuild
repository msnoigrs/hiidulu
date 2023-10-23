# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

EGIT_REPO_URI="https://github.com/saibing/bingo.git"
EGOPATH="${WORKDIR}/go"

DESCRIPTION="Go language server that speaks Language Server Protocol"
HOMEPAGE="https://github.com/saibing/bingo"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/go-1.12"

src_unpack() {
	git-r3_src_unpack
	cd "${S}"
	GO111MODULE=on GOPATH="${EGOPATH}" go get -u
}

src_compile() {
	GO111MODULE=on GOPATH="${EGOPATH}" go build -v
}

src_install() {
	dobin bingo
}
