# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit bash-completion-r1

EGO_PN="github.com/gohugoio/hugo"
EGOPATH="${WORKDIR}/go"

DESCRIPTION="A Fast and Flexible Static Site Generator built with love in Go"
HOMEPAGE="https://gohugo.io https://github.com/gohugoio/hugo"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

src_unpack() {
	default
	cd "${S}"
	GO111MODULE=on GOPATH="${EGOPATH}" go get
}

src_compile() {
	GO111MODULE=on GOPATH="${EGOPATH}" go build -v
	./hugo gen man || die
	mkdir bash
	cd bash
	../hugo gen autocomplete --completionfile hugo || die
}

src_install() {
	dobin hugo
	dobashcomp bash/hugo || die
	doman man/*
}
