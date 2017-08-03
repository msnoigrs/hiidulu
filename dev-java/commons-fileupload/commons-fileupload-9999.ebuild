# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="doc source"
EGIT_REPO_URI="https://github.com/apache/commons-fileupload.git"

inherit git-r3 java-pkg-2 java-ant-2

DESCRIPTION="A Java library for adding robust, high-performance, file upload capability to your servlets and web applications."
HOMEPAGE="http://commons.apache.org/fileupload/"
SRC_URI=""
COMMON_DEPEND="dev-java/commons-io:1"
DEPEND=">=virtual/jdk-1.6
	java-virtuals/servlet-api:3.0
	dev-java/portletapi:2.0
	test? (
		dev-java/ant-junit
		=dev-java/junit-3.8*
	)
	${COMMON_DEPEND}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEPEND}"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="test"

EANT_EXTRA_ARGS="-Dnoget=true -Dcommons-io.jar=true"

java_prepare() {
	epatch "${FILESDIR}/commons-fileupload-build.patch"

	#echo "maven.build.finalName=${PN}" >> build.properties

	mkdir -p "${S}/lib" || die
	cd "${S}/lib"
	java-pkg_jar-from commons-io-1
	java-pkg_jar-from --build-only portletapi-2.0
	java-pkg_jar-from --build-only servlet-api-3.0 servlet-api.jar
}

src_test() {
	mkdir -p target/lib/junit/jars
	java-pkg_jar-from --into "${S}"/target/lib/junit/jars junit junit.jar junit-3.8.1.jar
	ANT_TASKS="ant-junit" eant test
}

src_install() {
	java-pkg_newjar target/${PN}*.jar
	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
