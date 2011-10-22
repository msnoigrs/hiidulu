# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source test"

ESVN_REPO_URI="https://svn.apache.org/repos/asf/commons/proper/codec/trunk"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Implementations of common encoders and decoders in Java."
HOMEPAGE="http://jakarta.apache.org/commons/codec/"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=virtual/jre-1.6"

DEPEND=">=virtual/jdk-1.6
	test? ( dev-java/ant-junit:0 )
	${RDEPEND}"

java_prepare() {
#	echo "conf.home=./src/conf" >> build.properties
#	echo "source.home=./src/main/java" >> build.properties
#	echo "build.home=./output" >> build.properties
#	echo "dist.home=./output/dist" >> build.properties
#	echo "test.home=./src/test" >> build.properties
#	echo "final.name=commons-codec" >> build.properties
	cp "${FILESDIR}"/gentoo-build.xml build.xml
}

JAVA_ANT_ENCODING="ISO-8859-1"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	#java-pkg_dojar output/dist/${PN}.jar
	java-pkg_dojar target/${PN}.jar

	#dodoc RELEASE-NOTES.txt || die
	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
