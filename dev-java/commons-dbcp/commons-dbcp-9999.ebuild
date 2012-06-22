# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

ESVN_REPO_URI="http://svn.apache.org/repos/asf/commons/proper/dbcp/trunk"

JAVA_PKG_IUSE="doc source"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Jakarta component providing database connection pooling API"
HOMEPAGE="http://commons.apache.org/dbcp/"
SRC_URI=""

COMMON_DEP="dev-java/commons-pool:2
	dev-java/geronimo-spec-jta"
RDEPEND=">=virtual/jre-1.6
		${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
		test? (
			dev-java/junit:0
			www-servers/tomcat:6
			dev-java/xerces:2
		)
		${COMMON_DEP}"
LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

java_prepare() {
	echo "commons-pool.jar=$(java-pkg_getjars commons-pool)" > build.properties
	echo "jta-spec.jar=$(java-pkg_getjars geronimo-spec-jta)" >> build.properties
}

EANT_BUILD_TARGET="build-jar"

src_install() {
	java-pkg_dojar dist/${PN}*.jar || die "Unable to install"
	dodoc README.txt || die
	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
