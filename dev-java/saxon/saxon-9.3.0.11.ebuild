# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="The SAXON package is a collection of tools for processing XML documents: XSLT processor, XSL library, parser."
MyPV=${PV%b}
SRC_URI="mirror://sourceforge/saxon/Saxon-HE/9.3/saxon${MyPV//./-}source.zip"
HOMEPAGE="http://saxon.sourceforge.net/"

LICENSE="MPL-1.1"
SLOT="9.3"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="
	dev-java/xom:0
	dev-java/jdom:0
	dev-java/dom4j:1"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"

S="${WORKDIR}"

java_prepare() {
	rm -rv net/sf/saxon/dotnet
	# don't support XQuery(jsr225)
	rm -rf net/sf/saxon/xqj
	sed -i -e '/\/\*DOTNETONLY\*\//d' net/sf/saxon/Configuration.java
#	sed -i -e '/com.saxonica.SchemaAwareTransformerFactory/d' net/sf/saxon/ant/AntTransform.java
	rm net/sf/saxon/option/sql/SQLElementFactory.java

	mkdir "${S}/src" || die
	mv net "${S}/src" || die

	cp -i "${FILESDIR}/saxon93-build.xml" build.xml || die

	mkdir "${S}/lib" || die
	cd lib
	java-pkg_jar-from --build-only ant-core ant.jar
#	java-pkg_jar-from jsr173
#	java-pkg_jar-from stax
	java-pkg_jar-from jdom
	java-pkg_jar-from xom
	java-pkg_jar-from dom4j-1

	cp -v "${FILESDIR}"/9.2-edition.properties "${S}"/src/edition.properties
#	cd ${S}
#	mkdir endorsed && cd endorsed
#	java-pkg_jar-from xml-commons-external-1.4
}

src_install() {
	java-pkg_dojar dist/*.jar
	java-pkg_register-ant-task
	# the jar is named saxon9 and and helps if new slots come along
	java-pkg_dolauncher ${PN}9.3 --main net.sf.saxon.Transform
	if use doc; then
		java-pkg_dojavadoc dist/doc/api doc/*
		java-pkg_dohtml doc/*
	fi
	#use examples && java-pkg_doexamples samples
	use source && java-pkg_dosrc src/*
}
