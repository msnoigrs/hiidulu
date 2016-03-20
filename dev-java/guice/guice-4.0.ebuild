# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
WANT_ANT_TASKS="dev-java/jarjar:1"
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Guice (pronounced'juice') is a lightweight dependency injection framework for Java 5"
HOMEPAGE="http://code.google.com/p/google-guice/"
SRC_URI="https://github.com/google/guice/archive/4.0.zip -> ${P}-src.zip"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS=""
IUSE="servletapi spring struts2"

COMMON_DEP="dev-java/aopalliance:1
	dev-java/geronimo-spec-jpa
	dev-java/javax-inject
	dev-java/asm:5
	dev-java/cglib:3
	dev-java/guava:18
	servletapi? ( dev-java/tomcat-servlet-api:3.0 )"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

RESTRICT="test"

S="${WORKDIR}/${P/_/-}"

JAVA_PKG_BSFIX_NAME="build.xml common.xml"
JAVA_ANT_CLASSPATH_TAGS="${JAVA_ANT_CLASSPATH_TAGS} javadoc"

java_prepare() {
#	epatch ${FILESDIR}/build-deps.patch
	#epatch "${FILESDIR}"/3-typeliteral.patch
	# http://code.google.com/p/google-guice/issues/detail?id=288
	#epatch "${FILESDIR}"/GUICE_ISSUE_288_20110119.patch

	#epatch "${FILESDIR}/04_java8-compatibility.diff"

	# workaround jarjar's missing class problem on java6
	sed -i -e '/keep/d' common.xml

	cp extensions/jmx/build.xml extensions/mini
	sed -i -e 's/guice-jmx/guice-mini/' extensions/mini/build.xml
	cp ${FILESDIR}/mini-build.properties extensions/mini/build.properties
	cp extensions/jmx/build.xml extensions/service
	sed -i -e 's/guice-jmx/guice-service/' extensions/service/build.xml
	cp ${FILESDIR}/service-build.properties extensions/service/build.properties

	if ! use spring; then
		rm -rv extensions/spring || die
		mkdir -p extensions/spring/lib/build || die
	fi
	if ! use struts2; then
		rm -rv extensions/struts2 || die
		mkdir -p extensions/struts2/lib/build || die
	fi
	if ! use servletapi; then
		rm -rv extensions/servlet || die
		mkdir -p extensions/servlet/lib/build || die
	fi

	einfo "Removing bundled jars and classes"
	rm -fv ${S}/lib/*.jar
	mv ${S}/lib/build/bnd-0.0.*.jar ${S}
	#mv ${S}/lib/build/jarjar-1.0rc8.jar ${S}
	rm -fv ${S}/lib/build/*.jar
	mv ${S}/bnd-0.0.*.jar ${S}/lib/build/
	#mv ${S}/jarjar-1.0rc8.jar ${S}/lib/build/
	rm -fv ${S}/lib/build/jdiff/*.jar
	#rm -rf ${S}/javadoc
	rm -fv ${S}/extensions/persist/lib/*.jar

	cd ${S}/lib
	java-pkg_jar-from aopalliance-1 aopalliance.jar
	java-pkg_jar-from javax-inject javax.inject.jar
	java-pkg_jar-from guava-18 guava.jar guava-16.0.1.jar

	cd ${S}/lib/build
	java-pkg_jar-from --build-only cglib-3 cglib.jar cglib-3.1.jar
	java-pkg_jar-from --build-only jarjar-1 jarjar.jar jarjar-1.1.jar
	java-pkg_jar-from --build-only asm-5 asm.jar asm-5.0.3.jar

	cd ${S}/extensions/persist/lib
	java-pkg_jar-from geronimo-spec-jpa geronimo-spec-jpa.jar ejb3-persistence.jar

	cd ${S}/extensions/persist/build/lib
	java-pkg_jar-from tomcat-servlet-api-3.0 servlet-api.jar servlet-api-2.5.jar
}

src_compile() {
	eant jar $(use_doc)
	eant -f extensions/assistedinject/build.xml jar
	eant -f extensions/grapher/build.xml jar
	eant -f extensions/jmx/build.xml jar
	eant -f extensions/jndi/build.xml jar
	eant -f extensions/mini/build.xml jar
	eant -f extensions/multibindings/build.xml jar
	eant -f extensions/persist/build.xml jar
	eant -f extensions/service/build.xml jar
	eant -f extensions/throwingproviders/build.xml jar
	use spring && eant -f extensions/spring/build.xml jar
	use struts2 && eant -f extensions/struts2/build.xml jar
	use servletapi && eant -f extensions/servlet/build.xml jar
}

src_install() {
	java-pkg_newjar build/dist/${PN}-snapshot.jar ${PN}.jar
	for ext in assistedinject grapher jmx jndi multibindings persist service throwingproviders
	do
		java-pkg_newjar extensions/${ext}/build/${PN}-${ext}-snapshot.jar ${PN}-${ext}.jar
	done

	use servletapi && java-pkg_newjar extensions/servlet/build/${PN}-servlet-snapshot.jar ${PN}-servlet.jar
	use doc && java-pkg_dojavadoc javadoc
	#use doc && java-pkg_dojavadoc build/javadoc
	if use source; then
		java-pkg_dosrc src/com
		for ext in assistedinject grapher jmx jndi multibindings persist service throwingproviders
		do
			java-pkg_dosrc extensions/${ext}/src/com
		done
		if use spring; then
			java-pkg_dosrc extensions/spring/src/com
		fi
		if use struts2; then
			java-pkg_dosrc extensions/struts2/src/com
		fi
		if use servletapi; then
			java-pkg_dosrc extensions/servlet/src/com
		fi
	fi
}
