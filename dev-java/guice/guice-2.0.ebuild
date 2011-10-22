# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
WANT_ANT_TASKS="dev-java/jarjar:1"
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Guice (pronounced'juice') is a lightweight dependency injection framework for Java 5"
HOMEPAGE="http://code.google.com/p/google-guice/"
SRC_URI="http://google-guice.googlecode.com/files/${P}-src.zip"
LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="servletapi spring struts2"

COMMON_DEP="dev-java/aopalliance:1"
DEPEND=">=virtual/jdk-1.5
	dev-java/asm:3
	dev-java/cglib:2.2
	servletapi? ( java-virtuals/servlet-api:3.0 )
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

RESTRICT="test"

S="${WORKDIR}/${P}-src"

JAVA_PKG_BSFIX_NAME="build.xml common.xml"
JAVA_ANT_CLASSPATH_TAGS="${JAVA_ANT_CLASSPATH_TAGS} javadoc"

java_prepare() {
	epatch "${FILESDIR}"/typeliteral.patch
	epatch "${FILESDIR}"/GUICE_ISSUE_343_SRC_ENHANCED_20090303.patch
	# workaround jarjar's missing class problem on java6
	sed -i -e '/keep/d' common.xml

	rm -rv spring/build
	rm -rv struts2/build
	rm -rv servlet/build
	rm -rv extensions/assistedinject/build
	rm -rv extensions/grapher/build
	rm -rv extensions/jmx/build
	rm -rv extensions/jndi/build
	rm -rv extensions/multibindings/build
	rm -rv extensions/throwingproviders/build

	if ! use spring; then
		rm -rv spring || die
		mkdir -p spring/lib/build || die
	fi
	if ! use struts2; then
		rm -rv struts2 || die
		mkdir -p struts2/lib/build || die
	fi
	if ! use servletapi; then
		rm -rv servlet || die
		mkdir -p servlet/lib/build || die
	fi
	einfo "Removing bundled jars and classes"
	rm -fv ${S}/lib/*.jar
	mv ${S}/lib/build/bnd-0.0.305.jar ${S}
	rm -fv ${S}/lib/build/*.jar
	mv ${S}/bnd-0.0.305.jar ${S}/lib/build/
	rm -rf ${S}/javadoc

	java-pkg_jar-from --into lib aopalliance-1 aopalliance.jar

	cd ${S}/lib/build
	java-pkg_jar-from --build-only cglib-2.2 cglib.jar cglib-2.2.1-snapshot.jar
	if use servletapi; then
		java-pkg_jar-from --build-only --virtual servlet-api-3.0 servlet-api.jar servlet-api-2.5.jar
	fi
	java-pkg_jar-from --build-only jarjar-1 jarjar.jar jarjar-1.0rc8.jar
	java-pkg_jar-from --build-only asm-3 asm.jar asm-3.1.jar
}

src_compile() {
	eant jar $(use_doc)
	eant -f extensions/assistedinject/build.xml jar
	eant -f extensions/grapher/build.xml jar
	eant -f extensions/jmx/build.xml jar
	eant -f extensions/jndi/build.xml jar
	eant -f extensions/multibindings/build.xml jar
	eant -f extensions/throwingproviders/build.xml jar
	use spring && eant -f spring/build.xml jar
	use struts2 && eant -f struts2/build.xml jar
	use servletapi && eant -f servlet/build.xml jar
}

src_install() {
	java-pkg_newjar build/dist/${PN}-${PV}.jar ${PN}.jar
	for ext in assistedinject grapher jmx jndi multibindings throwingproviders
	do
		java-pkg_newjar extensions/${ext}/build/${PN}-${ext}-${PV}.jar ${PN}-${ext}.jar
	done

	use servletapi && java-pkg_newjar servlet/build/${PN}-servlet-${PV}.jar ${PN}-servlet.jar
	use doc && java-pkg_dojavadoc build/javadoc
	if use source; then
		java-pkg_dosrc src/com
		for ext in assistedinject grapher jmx jndi multibindings throwingproviders
		do
			java-pkg_dosrc extensions/${ext}/src/com
		done
		if use spring; then
			java-pkg_dosrc spring/src/com
		fi
		if use struts2; then
			java-pkg_dosrc struts2/src/com
		fi
		if use servletapi; then
			java-pkg_dosrc servlet/src/com
		fi
	fi
}
