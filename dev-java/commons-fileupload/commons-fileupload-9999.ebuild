# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"
ESVN_REPO_URI="https://svn.apache.org/repos/asf/commons/proper/fileupload/trunk"

inherit subversion eutils java-pkg-2 java-ant-2

DESCRIPTION="A Java library for adding robust, high-performance, file upload capability to your servlets and web applications."
HOMEPAGE="http://commons.apache.org/fileupload/"
SRC_URI=""
COMMON_DEPEND="dev-java/commons-io:1"
DEPEND=">=virtual/jdk-1.5
	java-virtuals/servlet-api:3.0
	dev-java/portletapi:2
	test? (
		dev-java/ant-junit
		=dev-java/junit-3.8*
	)
	${COMMON_DEPEND}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEPEND}"
LICENSE="Apache-2.0"
JAVA_PKG_FILTER_COMPILER="jikes"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="test"

EANT_EXTRA_ARGS="-Dnoget=true -Dcommons-io.jar=true"

java_prepare() {
	# Tweak build classpath and don't automatically run tests
	sed -i -e 's/depends="compile,test"/depends="compile"/' \
		-e 's/depends="get-deps"/depends=""/g' \
		-e 's:commons-io/jars/commons-io-1.3.2.jar:commons-io.jar:' \
		-e 's:javax.servlet/jars/servlet-api-2.4.jar:servlet-api.jar:' \
		-e 's:javax.portlet/jars/portlet-api-1.0.jar:portletapi.jar:' \
		build.xml || die

	echo "libdir=target/lib" >> build.properties
	echo "final.name=${PN}" >> build.properties

	mkdir -p "${S}/target/lib" || die
	cd "${S}/target/lib"
	java-pkg_jar-from commons-io-1
	java-pkg_jar-from --build-only portletapi-2
	java-pkg_jar-from --build-only servlet-api-3.0 servlet-api.jar
}

src_test() {
	mkdir -p target/lib/junit/jars
	java-pkg_jar-from --into "${S}"/target/lib/junit/jars junit junit.jar junit-3.8.1.jar
	ANT_TASKS="ant-junit" eant test
}

src_install() {
	java-pkg_dojar target/${PN}.jar
	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
