# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
EGO_PN="github.com/golang/lint/..."

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	EGIT_COMMIT=9bad2ac
	ARCHIVE_URI="https://github.com/golang/lint.git/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="a linker for Go source code"
HOMEPAGE="https://github.com/golang/lint"
SRC_URI="${ARCHIVE_URI}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND="dev-go/go-tools"
RDEPEND=""

src_compile() {
	golang-build_src_compile
	EGO_PN="github.com/golang/lint/golint" golang-build_src_compile
}

src_install() {
	dobin golint
}
