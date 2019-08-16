# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

EGIT_REPO_URI="https://github.com/noborus/trdsql.git"
EGOPATH="${WORKDIR}/go"

DESCRIPTION="A tool that can execute SQL queries on CSV,LTSV,JSON and TBLN"
HOMEPAGE="https://github.com/noborus/trdsql"
KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"
IUSE=""

src_unpack() {
	git-r3_src_unpack
	cd "${S}"
	GO111MODULE=on GOPATH="${EGOPATH}" go get
}

src_compile() {
	cd "${S}/cmd/trdsql"
	GO111MODULE=on GOPATH="${EGOPATH}" go build -v -tags json1
}

src_install() {
	dobin cmd/trdsql/trdsql
}
