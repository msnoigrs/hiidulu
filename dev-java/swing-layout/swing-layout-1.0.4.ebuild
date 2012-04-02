# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Professional cross platform layouts with Swing"
HOMEPAGE="http://java.net/projects/swing-layout/"
SRC_URI="https://swing-layout.dev.java.net/files/documents/2752/70793/${P}-src.zip"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

EANT_FILTER_COMPILER=jikes

src_install(){
	java-pkg_dojar dist/swing-layout.jar
	dodoc releaseNotes.txt || die
	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc src/java/org
}
