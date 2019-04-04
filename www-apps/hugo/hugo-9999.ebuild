# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 bash-completion-r1

EGIT_REPO_URI="https://github.com/gohugoio/hugo.git"
EGOPATH="${WORKDIR}/go"

DESCRIPTION="A Fast and Flexible Static Site Generator built with love in Go"
HOMEPAGE="https://gohugo.io https://github.com/gohugoio/hugo"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

src_unpack() {
	git-r3_src_unpack
	cd "${S}"
	GO111MODULE=on GOPATH="${EGOPATH}" go get -u
}

src_compile() {
	GO111MODULE=on GOPATH="${EGOPATH}" go build -v
	mkdir man
	cd man
	../hugo gen man || die
	cd ..
	mkdir bash
	cd bash
	../hugo gen autocomplete --completionfile hugo || die
}

src_install() {
	dobin hugo
	dobashcomp bash/hugo || die
	doman man/*
}
