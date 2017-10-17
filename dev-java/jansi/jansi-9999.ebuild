# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/fusesource/jansi.git"

JAVA_PKG_IUSE="doc source"

inherit git-r3 java-pkg-2 java-ant-2

DESCRIPTION="Jansi is a small java library that allows you to use ANSI escape sequences in your console output"
HOMEPAGE="http://jansi.fusesource.org/"
#SRC_URI="http://jansi.fusesource.org/repo/release/org/fusesource/jansi/jansi/${PV}/${P}-sources.jar"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

COMMON_DEP="dev-java/jansi-native
	dev-java/hawtjni-runtime"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"

java_prepare() {
	cd ${PN}

	mkdir lib
	java-pkg_jar-from --into lib jansi-native
	java-pkg_jar-from --into lib hawtjni-runtime
	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

src_compile() {
	cd ${PN}
	EANT_EXTRA_ARGS="-Dproject.name=${PN}" java-pkg-2_src_compile
}

src_install() {
	cd ${PN}
	java-pkg_newjar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/html/
	use source && java-pkg_dosrc src/java/com
}
