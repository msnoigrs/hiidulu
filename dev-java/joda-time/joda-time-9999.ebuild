# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc examples source"

EGIT_REPO_URI="git://github.com/JodaOrg/joda-time.git"

inherit java-pkg-2 java-ant-2 git-2

#MY_P="${P}-dist"

DESCRIPTION="A quality open-source replacement for the Java Date and Time classes."
HOMEPAGE="http://joda-time.sourceforge.net/"
#SRC_URI="mirror://sourceforge/${PN}/${PV}/${MY_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEP="dev-java/joda-convert"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

java_prepare() {
	mkdir lib
	java-pkg_jar-from --into lib joda-convert

	cp "${FILESDIR}/gentoo-build-2.xml" build.xml
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_newjar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use examples && java-pkg_doexamples src/example
	use source && java-pkg_dosrc src/main/java/org
}
