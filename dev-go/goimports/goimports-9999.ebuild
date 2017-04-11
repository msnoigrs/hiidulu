# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
EGO_PN=golang.org/x/tools/cmd/goimports

#if [[ ${PV} = *9999* ]]; then
#	inherit golang-vcs
#else
#	EGIT_COMMIT=be986a3
#	ARCHIVE_URI="https://github.com/jstemmer/gotags.git/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
#	KEYWORDS="~amd64"
#	inherit golang-vcs-snapshot
#fi
inherit golang-vcs
inherit golang-build

DESCRIPTION="Tool to fix (add, remove) your Go imports automatically"
HOMEPAGE="https://godoc.org/golang.org/x/tools/cmd/goimports"
SRC_URI="${ARCHIVE_URI}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND=""
RDEPEND=""

src_install() {
	dobin goimports
}
