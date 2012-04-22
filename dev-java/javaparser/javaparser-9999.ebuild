# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

WANT_ANT_TASKS="ant-nodeps"
JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="http://javaparser.googlecode.com/svn/trunk/JavaParser"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Java 1.5 Parser and AST"
HOMEPAGE="http://code.google.com/p/javaparser/"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"

#COMMON_DEP="
#	dev-java/jchardet
#	dev-java/xom
#	dev-java/icu4j:4.6"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	dev-java/javacc
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	rm -rv ant
}

JAVA_ANT_ENCODING="iso-8859-1"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/*
}
