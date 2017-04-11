# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
EGO_PN=gopkg.in/yaml.v2

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	EGIT_COMMIT=c522e7d
	ARCHIVE_URI="https://github.com/go-yaml/yaml.git/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="YAML support for the Go language"
HOMEPAGE="https://github.com/go-yaml/yaml"
SRC_URI="${ARCHIVE_URI}"
LICENSE="LGPL-3-with-linking-exception"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
#DEPEND="dev-go/go-colortext:="
RDEPEND=""
