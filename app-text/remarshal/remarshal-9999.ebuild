# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
EGO_PN=github.com/dbohdan/remarshal

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	EGIT_COMMIT=c522e7d
	ARCHIVE_URI="https://github.com/dbohdan/remarshal.git/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Convert between TOML, YAML and JSON"
HOMEPAGE="https://github.com/dbohdan/remarshal"
SRC_URI="${ARCHIVE_URI}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
#DEPEND="dev-go/go-colortext:="
RDEPEND=""

src_install() {
	dobin remarshal
	for i in toml yaml json; do
		for o in toml yaml json; do
			ln -s ./remarshal "${ED}/usr/bin/${i}2${o}"
		done
	done
}
