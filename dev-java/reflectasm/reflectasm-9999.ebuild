# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="dev-java/jarjar:1"

EGIT_REPO_URI="https://github.com/EsotericSoftware/reflectasm.git"

inherit git-2 java-pkg-2 java-ant-2

DESCRIPTION="High performance Java reflection"
HOMEPAGE="https://github.com/EsotericSoftware/reflectasm/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

COMMON_DEPEND="dev-java/asm:5"
RDEPEND="${COMMON_DEPEND}
	>=virtual/jre-1.6"
DEPEND="${COMMON_DEPEND}
	>=virtual/jdk-1.6
	test? (
		dev-java/junit:4
		dev-java/ant-junit4:0
	)"

java_prepare() {
	rm lib/*.jar build/*.jar

	cp "${FILESDIR}"/gentoo-build.xml build.xml || die

	java-pkg_jar-from --into lib asm-5 asm.jar
	java-pkg_jar-from --into lib asm-5 asm-commons.jar
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"
EANT_BUILD_TARGET="jar-shaded jar"

src_test() {
	java-pkg-2_src_test
}

src_install() {
	java-pkg_dojar target/${PN}.jar
	java-pkg_dojar target/${PN}-shaded.jar
	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src
}
