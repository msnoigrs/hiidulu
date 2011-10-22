# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Guice (pronounced'juice') is a lightweight dependency injection framework for Java 5"
HOMEPAGE="http://code.google.com/p/google-guice/"
SRC_URI="http://google-guice.googlecode.com/files/${P}-src.zip"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="servletapi"

COMMON_DEP="dev-java/aopalliance:1
	dev-java/asm:3
	dev-java/cglib:2.2
	servletapi? ( dev-java/tomcat-servlet-api:2.5 )"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

S="${WORKDIR}"
RESTRICT="test"

JAVA_PKG_BSFIX_NAME="build.xml common.xml servlet/build.xml"
JAVA_ANT_CLASSPATH_TAGS="${JAVA_ANT_CLASSPATH_TAGS} javadoc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/build_xml.patch"
	rm -rv struts2 spring || die
	if ! use servletapi; then
		rm -rv servlet || die
		mkdir -p servlet/lib/build || die
	fi
	einfo "Removing bundled jars and classes"
	find "${S}" -name '*.class' -print -delete
	find "${S}" -name '*.jar' -print -delete
	rm -rf ${S}/javadoc

	java-ant_rewrite-classpath common.xml
	use servletapi && java-ant_rewrite-classpath servlet/build.xml
	java-ant_rewrite-classpath build.xml
}

src_compile() {
	local cps=$(java-pkg_getjar aopalliance-1 aopalliance.jar)
	cps="${cps}:$(java-pkg_getjar cglib-2.2 cglib.jar)"
	cps="${cps}:$(java-pkg_getjar asm-3 asm.jar)"
	cps="${cps}:$(java-pkg_getjar asm-3 asm-commons.jar)"
	echo ${cps}
	eant -Dgentoo.classpath=${cps} jar $(use_doc)
	use servletapi && eant -Dgentoo.classpath=$(java-pkg_getjars tomcat-servlet-api-2.5) -f servlet/build.xml jar
}

src_install() {
	java-pkg_newjar build/dist/${P}.jar ${PN}.jar
	use servletapi && java-pkg_newjar servlet/build/${PN}-servlet-${PV}.jar ${PN}-servlet.jar
	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc src/com
}
