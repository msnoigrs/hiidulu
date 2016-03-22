# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
EGO_PN=github.com/jstemmer/gotags

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	EGIT_COMMIT=be986a3
	ARCHIVE_URI="https://github.com/jstemmer/gotags.git/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="ctags-compatible tag generator for Go"
HOMEPAGE="https://github.com/jstemmer/gotags"
SRC_URI="${ARCHIVE_URI}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND="dev-go/9fans-acme:="
RDEPEND=""

src_install() {
	dobin gotags
}
