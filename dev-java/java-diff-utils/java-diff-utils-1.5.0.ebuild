# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

JAVA_PKG_IUSE="source doc"

inherit java-pkg-2 java-ant-2

MY_P="${PN}-diffutils-${PV}"
DESCRIPTION="The DiffUtils library for computing diffs."
HOMEPAGE="https://github.com/KengoTODA/java-diff-utils"
SRC_URI="https://github.com/KengoTODA/java-diff-utils/archive/diffutils-${PV}.zip"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="dev-java/guava:18
	dev-java/jsr305:0"
DEPEND=">=virtual/jdk-1.7
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.7
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir "${S}/lib" || die
	cd "${S}/lib"
	java-pkg_jar-from guava-18
	java-pkg_jar-from jsr305
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
