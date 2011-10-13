# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc examples source"

EGIT_REPO_URI="git://github.com/JodaOrg/joda-convert.git"

inherit java-pkg-2 java-ant-2 git-2

MY_P="${P}-dist"

DESCRIPTION="A small set of classes to aid conversion between Objects and Strings."
HOMEPAGE="http://joda-convert.sourceforge.net/"
#SRC_URI="mirror://sourceforge/${PN}/${PV}/${MY_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_newjar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use examples && java-pkg_doexamples src/example
	use source && java-pkg_dosrc src/main/java/org
}
