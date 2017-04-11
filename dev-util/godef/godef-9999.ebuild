# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
EGO_PN=github.com/rogpeppe/godef

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	EGIT_COMMIT=f90a996
	ARCHIVE_URI="https://github.com/rogpeppe/godef.git/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Print where symbols are defined in Go source code"
HOMEPAGE="https://github.com/rogpeppe/godef"
SRC_URI="${ARCHIVE_URI}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND="dev-go/9fans-acme:="
RDEPEND=""

src_install() {
	dobin godef
}
