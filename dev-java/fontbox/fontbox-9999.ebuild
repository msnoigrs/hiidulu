# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="http://svn.apache.org/repos/asf/pdfbox/trunk/fontbox"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="An open source Java library for parsing font files"
HOMEPAGE="http://pdfbox.apache.org/"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

COMMON_DEP="dev-java/jcl-over-slf4j"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"

java_prepare() {
	#epatch "${FILESDIR}/zuki-fontbox.patch"
	#epatch "${FILESDIR}/zuki-fontbox-ucs4.patch"
	#epatch "${FILESDIR}/zuki-fontbox-cmap.patch"
	#epatch "${FILESDIR}/fontbox-zuki.patch"

	mkdir lib || die
	java-pkg_jar-from --into lib jcl-over-slf4j

	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
