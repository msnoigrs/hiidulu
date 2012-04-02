# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

JAVA_PKG_IUSE="doc source"

EHG_REPO_URI="https://bitbucket.org/validator/xmlparser"

inherit mercurial java-pkg-2 java-ant-2

DESCRIPTION="io xml util"
HOMEPAGE="http://about.validator.nu/"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

COMMON_DEP="dev-java/validator-nu-htmlparser"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	sed -i -e '/import com.ibm.icu.text.UnicodeSet;/d' src/nu/validator/gnu/xml/aelfred2/XmlParser.java

	mkdir lib && cd lib

	java-pkg_jar-from validator-nu-htmlparser htmlparser.jar

#	java-pkg_jar-from icu4j-4.6 icu4j.jar
}

EANT_EXTRA_ARGS="-Dproject.name=hs-aelfred2"

src_install() {
	java-pkg_dojar target/hs-aelfred2.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/*
}
