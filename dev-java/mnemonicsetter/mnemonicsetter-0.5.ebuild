# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Automatically assigns mnemonics to menu items and toolbar elements"
HOMEPAGE="https://github.com/dpolivaev/mnemonicsetter"
SRC_URI="https://github.com/dpolivaev/${PN}/archive/${PN}_0.5.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=virtual/jre-1.8"
DEPEND=">=virtual/jdk-1.8"

S="${WORKDIR}/${PN}-${PN}_${PV}"
JAVA_SRC_DIR="src"

src_prepare() {
	rm -rf src/test
}
