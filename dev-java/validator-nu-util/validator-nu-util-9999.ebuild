# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

JAVA_PKG_IUSE="doc source"

EHG_REPO_URI="https://bitbucket.org/validator/util"

inherit mercurial java-pkg-2 java-ant-2

DESCRIPTION="io xml util"
HOMEPAGE="http://about.validator.nu/"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

COMMON_DEP="dev-java/validator-nu-html5-datatypes
	app-text/validator-nu-jing
	dev-java/validator-nu-htmlparser
	dev-java/commons-httpclient:3
	dev-java/jcl-over-slf4j
	dev-java/log4j-over-slf4j
	dev-java/iri"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	java-virtuals/servlet-api:3.0
	${COMMON_DEP}"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir lib && cd lib

	java-pkg_jar-from validator-nu-html5-datatypes
	java-pkg_jar-from validator-nu-jing jing.jar
	java-pkg_jar-from validator-nu-htmlparser htmlparser.jar
	java-pkg_jar-from iri
	java-pkg_jar-from --virtual --build-only servlet-api-3.0 servlet-api.jar
	java-pkg_jar-from commons-httpclient-3
	java-pkg_jar-from jcl-over-slf4j
	java-pkg_jar-from log4j-over-slf4j
}

EANT_EXTRA_ARGS="-Dproject.name=io-xml-util"

src_install() {
	java-pkg_dojar target/io-xml-util.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/*
}
