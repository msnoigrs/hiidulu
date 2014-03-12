# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"

EGIT_REPO_URI="http://code.google.com/p/guava-libraries/"

inherit java-pkg-2 java-ant-2 git-2

DESCRIPTION="The Google Collections Library is a suite of new collections and collection-related goodness for Java 5.0"
HOMEPAGE="http://code.google.com/p/guava-libraries/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

#	dev-java/junit:4
COMMON_DEP="dev-java/jsr305
	dev-java/javax-inject"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

RESTRICT="test"

java_prepare() {
	cd guava
	cp ${FILESDIR}/gentoo-build.xml build.xml
	rm -v lib/*.jar
	java-pkg_jar-from --into lib jsr305
	java-pkg_jar-from --into lib javax-inject javax.inject.jar
	#java-pkg_jar-from --into lib junit-4
	#sed -i -e 's/\(name="jar" depends="compile\),testfw"/\1"/' build.xml
	# dummy dir
	#mkdir -p build/testfwclasses
}

src_compile() {
	#EANT_EXTRA_ARGS="-Djava5home=$(java-config -O)" \
	#	java-pkg-2_src_compile
	cd guava
	EANT_EXTRA_ARGS="-Dproject.name=${PN}" \
	java-pkg-2_src_compile
}

src_install() {
	cd guava
	#java-pkg_newjar build/dist/guava-unknown/guava-unknown.jar
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc src/com
}
