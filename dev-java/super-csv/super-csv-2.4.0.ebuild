# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

JAVA_PKG_IUSE="source doc"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A fast, programmer-friendly, free CSV library for Java"
HOMEPAGE="http://supercsv.sourceforge.net/"
SRC_URI="https://github.com/super-csv/super-csv/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

S="${WORKDIR}/${P}"

java_prepare() {
	cd "${PN}"
	cp ${FILESDIR}/gentoo-build.xml build.xml
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_compile() {
	cd "${PN}"
	java-pkg-2_src_compile
}

src_install() {
	cd "${PN}"
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
