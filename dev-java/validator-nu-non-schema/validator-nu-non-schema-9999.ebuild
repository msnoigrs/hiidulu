# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

JAVA_PKG_IUSE="doc source"

EHG_REPO_URI="https://bitbucket.org/validator/syntax"
EHG_PROJECT="validator-nu-validator"

inherit mercurial java-pkg-2 java-ant-2

DESCRIPTION="non schema"
HOMEPAGE="http://about.validator.nu/"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

COMMON_DEP="dev-java/validator-nu-html5-datatypes
	app-text/validator-nu-jing
	dev-java/relaxng-datatype
	dev-java/icu4j:4.6"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"

JAVA_ANT_ENCODING="iso-8859-1"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir lib && cd lib

	java-pkg_jar-from validator-nu-html5-datatypes
	java-pkg_jar-from validator-nu-jing jing.jar
	java-pkg_jar-from relaxng-datatype
	java-pkg_jar-from icu4j-4.6 icu4j.jar
}

EANT_EXTRA_ARGS="-Dproject.name=non-schema"

src_install() {
	java-pkg_dojar target/non-schema.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc non-schema/java/src/*
}
