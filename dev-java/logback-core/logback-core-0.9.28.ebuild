# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="source doc"

#inherit subversion java-pkg-2 java-ant-2
inherit java-pkg-2 java-ant-2

DESCRIPTION="Logback is intended as a successor to the popular log4j project."
HOMEPAGE="http://logback.qos.ch/"
SRC_URI="http://logback.qos.ch/dist/logback-${PV}.tar.gz"

LICENSE="|| ( EPL-1.0 LGP-2.1 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEP="java-virtuals/javamail
	dev-java/janino:2.6"
DEPEND=">=virtual/jdk-1.5
	java-virtuals/servlet-api:3.0
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

S="${WORKDIR}/logback-${PV}/${PN}"

java_prepare() {
	cd ${PN}
	cp "${FILESDIR}/gentoo-build.xml" build.xml
	mkdir lib || die
	java-pkg_jar-from --virtual --into lib --build-only --virtual servlet-api-3.0 servlet-api.jar
	java-pkg_jar-from --virtual --into lib javamail
	java-pkg_jar-from --into lib janino-2.6
}

#JAVA_ANT_ENCODING="utf-8"
JAVA_ANT_ENCODING="iso8859-1"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_compile() {
	cd ${PN}
	java-pkg-2_src_compile
}

src_install() {
	cd ${PN}
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
