# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="https://svn.java.net/svn/pdf-renderer~svn/trunk"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="a 100% Java PDF renderer and viewer"
HOMEPAGE="http://java.net/projects/pdf-renderer/"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

S="${WORKDIR}/${PN}"

JAVA_PKG_BSFIX_ALL="no"

java_prepare() {
	find -name '*.jar' -print -delete

	java-ant_bsfix_one nbproject/build-impl.xml
}

src_install() {
	java-pkg_newjar dist/PDFRenderer.jar ${PN}.jar

	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc src/com
}
