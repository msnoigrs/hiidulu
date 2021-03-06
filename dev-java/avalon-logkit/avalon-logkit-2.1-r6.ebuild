# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4
JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Easy-to-use Java logging toolkit"
HOMEPAGE="http://avalon.apache.org/"
SRC_URI="mirror://apache/excalibur/excalibur-logkit/source/${P}-src.tar.gz"

KEYWORDS="amd64 ppc ~ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
LICENSE="Apache-2.0"
SLOT="2.0"
IUSE=""

COMMON_DEP="
	java-virtuals/jms
	dev-java/oracle-javamail"
#	dev-java/log4j

RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
# Doesn't like 1.6 changes to JDBC
DEPEND=">=virtual/jdk-1.6
	java-virtuals/servlet-api:3.0
	test? (
		=dev-java/junit-3*
		dev-java/ant-junit
	)
	${COMMON_DEP}"

java_prepare() {
	epatch "${FILESDIR}/${P}-java7.patch"

	java-ant_ignore-system-classes

	java-ant_xml-rewrite -f build.xml \
		-c -e available -a classpathref -v 'build.classpath' || die

	rm -rv src/java/org/apache/log/output/lf5

	mkdir -p target/lib || die
	cd target/lib || die
	java-pkg_jar-from --build-only --virtual servlet-api-3.0
	java-pkg_jar-from --virtual jms
	java-pkg_jar-from oracle-javamail
	#java-pkg_jar-from log4j
	java-pkg_filter-compiler jikes
}

src_test() {
	java-pkg_jar-from --into target/lib junit
	ANT_TASKS="ant-junit" eant test
}

src_install() {
	java-pkg_newjar target/${P}.jar
	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
