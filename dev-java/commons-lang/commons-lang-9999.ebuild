# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source test"

ESVN_REPO_URI="https://svn.apache.org/repos/asf/commons/proper/lang/trunk"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Commons components to manipulate core java classes"
HOMEPAGE="http://commons.apache.org/lang/"
SRC_URI=""
IUSE=""

DEPEND=">=virtual/jdk-1.5
	dev-java/jcip-annotations
	test? ( dev-java/ant-junit:0 )"
RDEPEND=">=virtual/jre-1.5"

LICENSE="Apache-2.0"
SLOT="3.0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"

#S="${WORKDIR}/${P}-src"

JAVA_ANT_ENCODING="ISO-8859-1"

java_prepare() {
	cp ${FILESDIR}/gentoo-build.xml build.xml
	mkdir lib || die
	java-pkg_jar-from --into lib --build-only jcip-annotations
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_newjar target/${PN}.jar

	dodoc RELEASE-NOTES.txt NOTICE.txt || die
	#dohtml *.html || die
	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/java/*
}
