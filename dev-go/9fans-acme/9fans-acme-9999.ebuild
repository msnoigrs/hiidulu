# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
EGO_PN=9fans.net/go/acme

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	EGIT_COMMIT=65b8cf0
	ARCHIVE_URI="https://github.com/9fans/go.git/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Packages and commands for using Plan 9 from Go"
HOMEPAGE="https://github.com/9fans/go"
SRC_URI="${ARCHIVE_URI}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND="dev-go/9fans-plan9:="
RDEPEND=""
