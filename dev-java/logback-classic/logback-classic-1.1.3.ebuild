# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
JAVA_PKG_IUSE="source doc"

WANT_ANT_TASKS="dev-java/groovy-ant:0"

#inherit subversion java-pkg-2 java-ant-2
inherit java-pkg-2 java-ant-2

DESCRIPTION="Logback is intended as a successor to the popular log4j project."
HOMEPAGE="http://logback.qos.ch/"
SRC_URI="http://logback.qos.ch/dist/logback-${PV}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEP="~dev-java/logback-core-${PV}
	dev-java/slf4j-api:0"
#	dev-java/janino:0
#	dev-java/groovy
#	dev-java/antlr:0
#	dev-java/asm:3
#	dev-java/commons-cli:1"
DEPEND=">=virtual/jdk-1.6
	dev-java/geronimo-spec-jms
	java-virtuals/servlet-api:3.0
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

S="${WORKDIR}/logback-${PV}/${PN}"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml
#	rm -v src/main/java/ch/qos/logback/classic/net/JMS*.java
	mkdir lib || die
	java-pkg_jar-from --into lib slf4j-api
	java-pkg_jar-from --into lib --build-only --virtual servlet-api-3.0 servlet-api.jar
	java-pkg_jar-from --into lib --build-only geronimo-spec-jms
	#java-pkg_jar-from --into lib janino
	java-pkg_jar-from --into lib logback-core
	#java-pkg_jar-from --into lib groovy
	#java-pkg_jar-from --into lib antlr
	#java-pkg_jar-from --into lib asm-3
	#java-pkg_jar-from --into lib commons-cli-1

#	rm -r src/main/java/ch/qos/logback/classic/gaffer
}

#src_compile() {
#	local classes="${S}/target/classes"
##	local javadocdir="${S}/target/javadoc"
#	local cps="$(java-pkg_getjars logback-core)"
#	cps="${cps}:$(java-pkg_getjars slf4j-api)"
#	cps="${cps}:$(java-pkg_getjar tomcat-servlet-api-2.5 servlet-api.jar)"
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

JAVA_ANT_ENCODING="utf-8"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

#src_compile() {
#	cd ${PN}
#	groovyc -d target/classes src/main/groovy/ch/qos/logback/classic/gaffer/GafferConfigurator.groovy
#	java-pkg-2_src_compile
#}

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
