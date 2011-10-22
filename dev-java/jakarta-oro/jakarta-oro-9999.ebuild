# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc example source"
ESVN_REPO_URI="http://svn.apache.org/repos/asf/jakarta/oro/trunk"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="A set of text-processing Java classes."
HOMEPAGE="http://jakarta.apache.org/oro/index.html"
SRC_URI=""
#SRC_URI="${P}.tar.bz2"
# svn -r390706 export http://svn.apache.org/repos/asf/jakarta/oro/trunk jakarta-oro-2.1_pre390706
# tar jcf jakarta-oro-2.1_pre390706.tar.bz2 jakarta-oro-2.1_pre390706
LICENSE="Apache-2.0"
SLOT="2.0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

EANT_EXTRA_ARGS="-Dfinal.name=${PN}"
EANT_BUILD_TARGET="jar"
EANT_DOC_TARGET="javadocs"

src_install() {
	java-pkg_newjar ${PN}-2.1-dev-1.jar ${PN}.jar
	java-pkg_newjar ${PN}-core-2.1-dev-1.jar ${PN}-core.jar
	java-pkg_newjar ${PN}-awk-2.1-dev-1.jar ${PN}-awk.jar
	java-pkg_newjar ${PN}-glob-2.1-dev-1.jar ${PN}-glob.jar
	java-pkg_newjar ${PN}-java-2.1-dev-1.jar ${PN}-java.jar
	java-pkg_newjar ${PN}-perl5-2.1-dev-1.jar ${PN}-perl5.jar
	java-pkg_newjar ${PN}-util-2.1-dev-1.jar ${PN}-util.jar

	if use doc; then
		dodoc CHANGES COMPILE CONTRIBUTORS ISSUES README STYLE TODO
		java-pkg_dohtml *.html
		java-pkg_dohtml -r docs/
	fi
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r src/java/examples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/java/org
}
