# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A suite of extremely fast and reliable parsers"
HOMEPAGE="https://github.com/uniVocity/univocity-parsers"
SRC_URI="https://github.com/uniVocity/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ppc64 x86"
IUSE=""

RDEPEND=">=virtual/jre-1.7"
DEPEND=">=virtual/jdk-1.7"
JAVA_SRC_DIR="src/main/java"

S="${WORKDIR}/${P}"
