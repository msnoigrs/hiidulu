# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

#ESVN_REPO_URI="http://svn.apache.org/repos/asf/wicket/releases/wicket-1.4-rc5/${PN}"

JAVA_PKG_IUSE="doc source"

#inherit java-pkg-2 java-ant-2 subversion
inherit java-pkg-2 java-ant-2

MY_PN="wicket"
MY_PV=${PV/_beta/-beta}
MY_P="apache-${MY_PN}-${MY_PV}"

DESCRIPTION="With proper mark-up/logic separation, a POJO data model, and a refreshing lack of XML"
HOMEPAGE="http://wicket.apache.org/"
SRC_URI="mirror://apache/${MY_PN}/${MY_PV}/${MY_P}.tar.gz"
#SRC_URI=""

LICENSE="Apache-2.0"
SLOT="6.0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="dev-java/wicket-core:${SLOT}
	dev-java/wicket-util:${SLOT}
	dev-java/slf4j-api"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}/src/${PN}"


java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir lib || die
	java-pkg_jar-from --into lib wicket-core-${SLOT}
	java-pkg_jar-from --into lib wicket-util-${SLOT}
	java-pkg_jar-from --into lib slf4j-api
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
