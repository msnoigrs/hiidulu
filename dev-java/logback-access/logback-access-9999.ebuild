# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

#ESVN_REPO_URI="http://svn.qos.ch/repos/logback/trunk/${PN}"
EGIT_REPO_URI="git://github.com/ceki/logback.git"
EGIT_PROJECT="logback"

JAVA_PKG_IUSE="source doc"

#inherit java-pkg-2 java-ant-2 subversion
inherit git-2 java-pkg-2 java-ant-2

DESCRIPTION="Logback is intended as a successor to the popular log4j project."
HOMEPAGE="http://logback.qos.ch/"
SRC_URI=""

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEP="=dev-java/logback-core-${PV}
	dev-java/slf4j-api
	www-server/tomcat:7
	dev-java/janino:0"
DEPEND=">=virtual/jdk-1.5
	java-virtuals/servlet-api:3.0
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

java_prepare() {
	cd ${PN}
	cp "${FILESDIR}/gentoo-build.xml" build.xml
	rm -rv src/main/java/ch/qos/logback/access/jetty

#	rm -v lib/*.jar
	java-pkg_jar-from --into lib slf4j-api
	java-pkg_jar-from --into lib logback-core
	java-pkg_jar-from --into lib janino
	java-pkg_jar-from --into lib --build-only --virtual servlet-api-2.5 servlet-api.jar
	java-pkg_jar-from --into lib tomcat-7 catalina.jar
}

JAVA_ANT_ENCODING="utf-8"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

#src_compile() {
#	local classes="${S}/target/classes"
##	local javadocdir="${S}/target/javadoc"
#	local cps="$(java-pkg_getjars logback-core)"
##	cps="${cps}:$(java-pkg_getjars slf4j-api)"
#	cps="${cps}:$(java-pkg_getjar tomcat-servlet-api-2.5 servlet-api.jar)"
#	cps="${cps}:$(java-pkg_getjar tomcat-6 catalina.jar)"
#	mkdir -p ${classes} || die
#	cd src/main/java
#	ejavac -encoding UTF-8 -d ${classes} -cp ${cps} $(find -name '*.java')
#
#	rsync --recursive --verbose\
#		--exclude '*.java' \
#		--exclude 'package.html' \
#		${S}/src/main/java/* ${classes}
#	jar cf ${S}/target/${PN}.jar -C ${classes} . || die "jar fail"
#}

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
