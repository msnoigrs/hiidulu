# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

JAVA_PKG_IUSE="source doc"

inherit java-pkg-2 java-ant-2

MY_PN="wicket"
MY_PV=${PV/_rc/-rc}
MY_P="apache-${MY_PN}-${MY_PV}"

DESCRIPTION="With proper mark-up/logic separation, a POJO data model, and a refreshing lack of XML"
HOMEPAGE="http://wicket.apache.org/"
SRC_URI="mirror://apache/${MY_PN}/${MY_PV}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="~dev-java/wicket-${PV}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}/src/${PN}"

java_prepare() {
	cp ${FILESDIR}/gentoo-build.xml build.xml
}

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="wicket"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
