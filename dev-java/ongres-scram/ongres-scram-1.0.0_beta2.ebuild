# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="scram"
MY_PV=${PV/_beta/-beta.}

DESCRIPTION="Automatically assigns mnemonics to menu items and toolbar elements"
HOMEPAGE="https://github.com/ongres/scram"
SRC_URI="https://github.com/ongres/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=virtual/jre-1.8"
DEPEND=">=virtual/jdk-1.8"

S="${WORKDIR}/${MY_PN}-${MY_PV}"
JAVA_SRC_DIR="src/main/java"

src_compile() {
	cd ${S}/common
	JAVA_JAR_FILENAME="common.jar" java-pkg-simple_src_compile
	cd ${S}/client
	JAVA_JAR_FILENAME="client.jar" JAVA_GENTOO_CLASSPATH_EXTRA="../common/common.jar" java-pkg-simple_src_compile
}

src_install() {
	cd ${S}/common
	JAVA_JAR_FILENAME="common.jar" java-pkg-simple_src_install
	cd ${S}/client
	JAVA_JAR_FILENAME="client.jar" java-pkg-simple_src_install
}
