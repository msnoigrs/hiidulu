# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"
ESVN_REPO_URI="https://svn.codehaus.org/jettison/tags/jettison-1.2"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Jettison is a collection of StAX parsers and writers which read and write JSON."
#SRC_URI="http://repository.codehaus.org/org/codehaus/${PN}/${PN}/${PV}/${P}-sources.jar"
HOMEPAGE="http://jettison.codehaus.org/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

#S="${WORKDIR}"

#src_unpack() {
#	unpack ${A}
#	cd ${S}
#
#	mkdir -p ${S}/src/main/java
#	mv org ${S}/src/main/java
#}

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/org
}
