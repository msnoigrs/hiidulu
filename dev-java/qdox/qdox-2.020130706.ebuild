# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

#ESVN_REPO_URI="https://svn.codehaus.org/qdox/tags/qdox-1.12"
JAVA_PKG_IUSE="doc source junit"

WANT_ANT_TASKS="dev-java/jflex:0"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Parser for extracting class/interface/method definitions"
HOMEPAGE="http://qdox.codehaus.org/"
SRC_URI="https://nexus.codehaus.org/content/repositories/snapshots/com/thoughtworks/qdox/qdox/2.0-SNAPSHOT/qdox-2.0-20130706.124819-8-project.tar.gz"
LICENSE="Apache-2.0"
SLOT="2.0"
KEYWORDS="~x86 ~amd64"
IUSE=""
S="${WORKDIR}/${PN}-2.0-SNAPSHOT"

COMMON_DEP="junit? ( dev-java/junit:4 )"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}
	dev-java/ant-core
	>=dev-java/byaccj-1.14"

java_prepare() {
	find . -depth -name .svn -type d -delete

	cp "${FILESDIR}"/gentoo-build-2.0.xml build.xml

	mkdir lib || die
	cd lib
	java-pkg_jarfrom --build-only ant-core ant.jar

	if use junit; then
		java-pkg_jarfrom junit-4 junit.jar
	else
		rm -rf ${S}/src/java/com/thoughtworks/qdox/junit
	fi
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar
	java-pkg_register-ant-task

	use source && java-pkg_dosrc src/java/com
	use doc && java-pkg_dojavadoc target/site/apidocs
}
