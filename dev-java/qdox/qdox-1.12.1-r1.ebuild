# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

JAVA_PKG_IUSE="doc source junit"

WANT_ANT_TASKS="dev-java/jflex:0"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Parser for extracting class/interface/method definitions"
HOMEPAGE="https://github.com/codehaus/qdox"
SRC_URI="https://github.com/codehaus/qdox/archive/${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="1.12"
KEYWORDS="~x86 ~amd64"
IUSE=""
S="${WORKDIR}/${PN}-${PN}-${PV}"

COMMON_DEP="junit? ( dev-java/junit:4 )"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}
	dev-java/ant-core
	>=dev-java/byaccj-1.14"

java_prepare() {
	epatch "${FILESDIR}"/jflex-1.6.1.patch

	find . -depth -name .svn -type d -delete

	cp "${FILESDIR}"/gentoo-build-jflex.xml build.xml

	mkdir lib || die
	cd lib
	java-pkg_jarfrom --build-only ant-core ant.jar

	if use junit; then
		java-pkg_jarfrom junit-4 junit.jar
	else
		rm ${S}/src/java/com/thoughtworks/qdox/tools/QDoxTester.java
		rm -rf ${S}/src/java/com/thoughtworks/qdox/junit
		rm -rf ${S}/src/test
	fi
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar
	java-pkg_register-ant-task

	use source && java-pkg_dosrc src/java/com
	use doc && java-pkg_dojavadoc target/site/apidocs
}
