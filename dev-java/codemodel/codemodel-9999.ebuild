# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="source doc"

ESVN_REPO_URI="https://svn.java.net/svn/codemodel~svn/trunk/codemodel/codemodel"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="CodeModel is a Java library for code generators"
HOMEPAGE="https://codemodel.java.net/"
#http://java.net/projects/codemodel/sources
SRC_URI=""

LICENSE="|| ( CDDL GPL-2 )"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
