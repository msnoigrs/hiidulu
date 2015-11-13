# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="source doc"

ESVN_REPO_URI="https://jortho.svn.sourceforge.net/svnroot/jortho/trunk/JOrtho"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="a Java spell-checking library"
HOMEPAGE="http://jortho.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

java_prepare() {
	cp ${FILESDIR}/build.xml build.xml
}

src_install() {
	java-pkg_dojar temp/${PN}.jar

	use doc && java-pkg_dohtml -r doc/*
	use source && java-pkg_dosrc src/com
}
