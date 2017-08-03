# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="doc source test"

WANT_ANT_TASKS="dev-java/ant-ivy:2"

inherit java-pkg-2 java-ant-2

DESCRIPTION="TestNG is a testing framework inspired from JUnit and NUnit"
HOMEPAGE="http://testng.org/"
SRC_URI="https://github.com/cbeust/${PN}/archive/${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/bsh:0
		dev-java/snakeyaml
		dev-java/jcommander:0
		dev-java/guice:3
		dev-java/junit:4"

DEPEND=">=virtual/jdk-1.6
		dev-java/ant-core:0
		${CDEPEND}"
RDEPEND=">=virtual/jre-1.6
		${CDEPEND}"

S="${WORKDIR}/${PN}-${P}"

java_prepare() {
	find . -iname '*.jar' -exec rm -v {} +

	epatch "${FILESDIR}/snakeyaml.patch"

	sed -i -e 's/depends="retrieve-dependencies"//' build.xml
	mkdir lib

	java-pkg_jar-from --into lib --build-only ant-core ant.jar
	java-pkg_jar-from --into lib junit-4
	java-pkg_jar-from --into lib snakeyaml snakeyaml.jar snakeyaml-1.12.jar
	java-pkg_jar-from --into lib jcommander jcommander.jar jcommander-1.27.jar
	java-pkg_jar-from --into lib bsh bsh.jar bsh-2.0b4.jar
	java-pkg_jar-from --into lib guice-3 guice.jar
}

src_compile() {
	EANT_BUILD_TARGET="build" EANT_EXTRA_ARGS="-Dall.jar.files=*.jar -Djunit.jar=junit.jar" java-pkg-2_src_compile
}

src_install() {
	java-pkg_newjar target/testng*.jar
	java-pkg_register-ant-task

	use doc && java-pkg_dojavadoc javadocs/
	use source && java-pkg_dosrc src/main/java/*
}
