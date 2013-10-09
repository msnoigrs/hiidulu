# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java library for working with XML"
HOMEPAGE="http://dom4j.sourceforge.net/"
SRC_URI="mirror://sourceforge/dom4j/${P}.tar.gz
	mirror://gentoo/${P}-java5.patch.bz2"
LICENSE="dom4j"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND=">=virtual/jre-1.6
	java-virtuals/jaxb-api:2
	java-virtuals/stax-api
	dev-java/xpp3:0
	dev-java/relaxng-datatype:0
	>=dev-java/xsdlib-20060319:0
	dev-java/xml-commons-external:1.4
	dev-java/jaxen:1.1"
#	dev-java/xerces:2
#	>=dev-java/msv-20081113:0
# Should look into why the tests fail with other versions
DEPEND="
	!test? ( >=virtual/jdk-1.6 )
	test? (
		=virtual/jdk-1.5*
		dev-java/ant-junit:0
		dev-java/xalan:0
		dev-java/junitperf:0
	)
	${RDEPEND}"

java_prepare() {
	# Add missing methods to compile on Java 5
	# see bug #137970
	epatch "${WORKDIR}/${P}-java5.patch"

	# Needs X11
	rm -v ./src/test/org/dom4j/bean/BeansTest.java || die
	rm -v *.jar || die
	# remove dependency xpp2
	rm -v ./src/java/org/dom4j/io/XPPReader.java || die
	rm -v ./src/java/org/dom4j/xpp/ProxyXmlStartTag.java || die
	cd "${S}/lib"
	java-pkg_jar-from jaxb-api-2
	java-pkg_jar-from stax-api
#	java-pkg_jar-from msv
	java-pkg_jar-from xpp3
	java-pkg_jar-from relaxng-datatype
	java-pkg_jar-from xsdlib
	java-pkg_jar-from xml-commons-external-1.4
	java-pkg_jar-from jaxen-1.1

	cd "${S}/lib/endorsed"
	rm -v *.jar || die
#	java-pkg_jar-from xerces-2 || die

	rm -vr "${S}"/lib/test/* || die
	if use test; then
		java-pkg_jar-from --build-only xalan,junitperf,junit
	fi
	rm -vr "${S}"/lib/tools/* || die
}

EANT_BUILD_TARGET="clean package"
EANT_EXTRA_ARGS="-Dbuild.javadocs=build/doc/api"

src_install() {
	java-pkg_dojar build/${PN}.jar
	use doc && java-pkg_dojavadoc build/doc/api
	use source && java-pkg_dosrc src/java/*
}
