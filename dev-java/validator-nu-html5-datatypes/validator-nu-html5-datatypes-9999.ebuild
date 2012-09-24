# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

JAVA_PKG_IUSE="doc source"

EHG_REPO_URI="https://bitbucket.org/validator/syntax"
EHG_PROJECT="validator-nu-validator"

inherit mercurial java-pkg-2 java-ant-2

DESCRIPTION="HTML5 Syntax"
HOMEPAGE="http://about.validator.nu/"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

COMMON_DEP="dev-java/relaxng-datatype
	dev-java/iri
	dev-java/rhino:1.6
	dev-java/icu4j:49"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir lib && cd lib
	java-pkg_jar-from relaxng-datatype
	java-pkg_jar-from iri
	java-pkg_jar-from rhino-1.6
	java-pkg_jar-from icu4j-49 icu4j.jar
}

EANT_EXTRA_ARGS="-Dproject.name=html5-datatypes"

src_install() {
	java-pkg_dojar target/html5-datatypes.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc relaxng/datatype/java/src/*
}
