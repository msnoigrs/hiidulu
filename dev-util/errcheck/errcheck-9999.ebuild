# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
EVCS_UMASK="000"
EGO_PN=github.com/kisielk/errcheck

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	EGIT_COMMIT=f76568f
	ARCHIVE_URI="https://github.com/kisielk/errcheck.git/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="errcheck checks that you checked errors"
HOMEPAGE="https://github.com/kisielk/errcheck"
SRC_URI="${ARCHIVE_URI}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND="dev-go/go-tools
	dev-go/gotool"
RDEPEND=""

src_install() {
	dobin errcheck
}
