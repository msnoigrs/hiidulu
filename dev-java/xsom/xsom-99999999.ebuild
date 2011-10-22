# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="https://svn.java.net/svn/xsom~sources/trunk"

WANT_ANT_TASKS="ant-nodeps ant-antlr dev-java/relaxngcc:0"
#WANT_ANT_TASKS="ant-nodeps"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="XML Schema Object Model (XSOM) is a Java library that allows applications to easily parse XML Schema documents and inspect information in them."
HOMEPAGE="http://xsom.java.net/"
SRC_URI=""

LICENSE="|| ( CDDL GPL-2-sun-classpath-exception )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

COMMON_DEP="dev-java/relaxng-datatype"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	dev-java/javacc
	${COMMON_DEP}"

java_prepare() {
	cp "${FILESDIR}"/build.xml build.xml

	java-pkg_jar-from --into lib relaxng-datatype
	java-pkg_jar-from --into lib --build-only javacc
}

src_install() {
	java-pkg_dojar build/xsom.jar

	use doc && java-pkg_dojavadoc build/javadoc
	use source && java-pkg_dosrc src/*
}
