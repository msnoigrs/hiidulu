# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

JAVA_PKG_IUSE="doc source"

EGIT_REPO_URI="https://github.com/FasterXML/jackson-databind.git"

inherit git-r3 java-pkg-2 java-ant-2

DESCRIPTION="High-performance JSON processor"
HOMEPAGE="http://jackson.codehaus.org"

LICENSE="|| ( Apache-2.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="dev-java/jackson-core
	dev-java/jackson-annotations"
RDEPEND=">=virtual/jre-1.8
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.8
	${COMMON_DEP}
"

EANT_TEST_GENTOO_CLASSPATH="junit-4"

java_prepare() {
	cp "${FILESDIR}"/gentoo-build.xml "${S}"/build.xml || die

	sed -e 's/@VERSION@/2.4.0-rc2-SNAPSHOT/' "${FILESDIR}/PackageVersion.java" > src/main/java/com/fasterxml/jackson/databind/cfg/PackageVersion.java

	mkdir lib || die
	java-pkg_jar-from --into lib jackson-core
	java-pkg_jar-from --into lib jackson-annotations
}

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs/
	use source && java-pkg_dosrc src/main/java/*
}
