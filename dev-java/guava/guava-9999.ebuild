# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="http://guava-libraries.googlecode.com/svn/trunk/"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="The Google Collections Library is a suite of new collections and collection-related goodness for Java 5.0"
HOMEPAGE="http://code.google.com/p/guava-libraries/"
SRC_URI=""
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

#	dev-java/junit:4
COMMON_DEP="dev-java/jsr305"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

RESTRICT="test"

java_prepare() {
	rm -v lib/*.jar
	java-pkg_jar-from --into lib jsr305
	#java-pkg_jar-from --into lib junit-4
	sed -i -e 's/\(name="jar" depends="compile\),testfw"/\1"/' build.xml
	# dummy dir
	mkdir -p build/testfwclasses
}

src_compile() {
	EANT_EXTRA_ARGS="-Djava5home=$(java-config -O)" \
		java-pkg-2_src_compile
}

src_install() {
	java-pkg_newjar build/dist/guava-unknown/guava-unknown.jar

	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc src/com
}
