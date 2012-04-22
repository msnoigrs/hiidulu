# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="https://svn.java.net/svn/dtd-parser~svn/trunk/dtd-parser"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Sun DTDParser"
HOMEPAGE="http://java.net/projects/dtd-parser"
#SRC_URI="mirror://gentoo/dtd-parser-${PV}-src.zip"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"

IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml || die
}

EANT_EXTRA_ARGS="-Dproject.name=dtd-parser"

src_install() {
	java-pkg_dojar target/dtd-parser.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/*
}
