# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
EGO_PN=github.com/BurntSushi/toml

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	EGIT_COMMIT=c522e7d
	ARCHIVE_URI="https://github.com/BurntSushi/toml.git/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="TOML parser for Golang with reflection"
HOMEPAGE="https://github.com/BurntSushi/toml"
SRC_URI="${ARCHIVE_URI}"
LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
#DEPEND="dev-go/go-colortext:="
RDEPEND=""
