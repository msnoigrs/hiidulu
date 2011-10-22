# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="https://svn.java.net/svn/deployment~svn/trunk/ant-tasks/pack200"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="ant Pack200 tasks"
HOMEPAGE="https://deployment.dev.java.net/"
#SRC_URI="http://www.pdoubleya.com/projects/${PN}/downloads/r${PV}/${PN}-R${PV}final-src.zip"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	dev-java/ant-core
	${COMMON_DEP}"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml
	mkdir lib || die
	java-pkg_jar-from --into lib --build-only ant-core ant.jar
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

RESTRICT="test"

src_install() {
	java-pkg_dojar target/${PN}.jar

	java-pkg_register-ant-task
	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
