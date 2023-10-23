# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

EGIT_REPO_URI="https://github.com/golang/protobuf"
EGOPATH="${WORKDIR}/go"

DESCRIPTION="Go support for Protocol Buffers"
HOMEPAGE="https://github.com/golang/protobuf"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/go-1.12"

src_unpack() {
	git-r3_src_unpack
	cd "${S}/protoc-gen-go"
	GO111MODULE=on GOPATH="${EGOPATH}" go get -u
}

src_compile() {
	cd "${S}/protoc-gen-go"
	GO111MODULE=on GOPATH="${EGOPATH}" go build -v
}

src_install() {
	cd "${S}/protoc-gen-go"
	dobin protoc-gen-go
}
