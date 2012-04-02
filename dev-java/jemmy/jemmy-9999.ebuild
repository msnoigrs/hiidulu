# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

WANT_ANT_TASKS="ant-nodeps"
JAVA_PKG_IUSE="source doc"

#ESVN_REPO_URI="https://svn.java.net/svn/jemmy~jemmy2"
EHG_REPO_URI="https://hg.java.net/hg/jemmy~jemmy3"

inherit mercurial java-pkg-2 java-ant-2

DESCRIPTION="Java UI testing tool"
HOMEPAGE="https://jemmy.java.net/"
SRC_URI=""

LICENSE="CDDL"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

JAVA_PKG_BSFIX_NAME="build.xml build-impl.xml"

src_compile() {
	cd AWT/Jemmy2
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar AWT/Jemmy2/build/${PN}.jar
	use doc && java-pkg_dojavadoc AWT/Jemmy2/build/javadoc
	use source && java-pkg_dosrc AWT/Jemmy2/src/org
}
