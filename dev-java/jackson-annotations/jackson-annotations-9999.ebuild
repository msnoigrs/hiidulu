# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc source test"

EGIT_REPO_URI="https://github.com/FasterXML/jackson-annotations.git"

inherit java-pkg-2 java-ant-2 git-2

DESCRIPTION="High-performance JSON processor"
HOMEPAGE="http://jackson.codehaus.org"

LICENSE="|| ( Apache-2.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="dev-java/jackson-core"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}
	test? (
		dev-java/ant-junit4
		dev-java/junit:4
	)
"

EANT_TEST_GENTOO_CLASSPATH="junit-4"

java_prepare() {
	cp "${FILESDIR}"/gentoo-build.xml "${S}"/build.xml || die

	mkdir lib || die
	java-pkg_jar-from --into lib jackson-core
}

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs/
	use source && java-pkg_dosrc src/main/java/*
}

src_test() {
	EANT_TASKS="ant-junit4"
	java-pkg-2_src_test
}
