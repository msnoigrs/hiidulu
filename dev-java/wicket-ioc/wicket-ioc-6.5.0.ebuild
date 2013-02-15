# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

JAVA_PKG_IUSE="source doc"

inherit java-pkg-2 java-ant-2

MY_PN="wicket"
MY_P="apache-${MY_PN}-${PV}"

DESCRIPTION="With proper mark-up/logic separation, a POJO data model, and a refreshing lack of XML"
HOMEPAGE="http://wicket.apache.org/"
SRC_URI="mirror://apache/${MY_PN}/${PV}/${MY_P}.tar.gz"
#SRC_URI=""

LICENSE="Apache-2.0"
SLOT="6.5"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="dev-java/wicket-util:${SLOT}
	dev-java/wicket-core:${SLOT}
	dev-java/cglib-nodep:2.2"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}/${PN}"

java_prepare() {
	cp ${FILESDIR}/gentoo-build.xml build.xml

	mkdir lib || die
	java-pkg_jar-from --into lib wicket-util-${SLOT}
	java-pkg_jar-from --into lib wicket-core-${SLOT}
	java-pkg_jar-from --into lib cglib-nodep-2.2
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
