# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
EGO_PN=github.com/nsf/gocode

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	EGIT_COMMIT=3b7488f
	ARCHIVE_URI="https://github.com/nsf/gocode.git/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="An autocompletion daemon for the Go programming language"
HOMEPAGE="https://github.com/nsf/gocode"
SRC_URI="${ARCHIVE_URI}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="emacs"
DEPEND=""
RDEPEND=""

src_install() {
	dobin gocode
}
