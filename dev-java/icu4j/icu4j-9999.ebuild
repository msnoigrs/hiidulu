# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# We currently download the Javadoc documentation.
# It could optionally be built using the Ant build file.
# testdata.jar and icudata.jar do not contain *.class files but *.res files
# These *.res data files are needed to built the final jar
# They do not need to be installed however as they will already be present in icu4j.jar

EAPI="2"
JAVA_PKG_IUSE="doc test source"
ESVN_REPO_URI="http://source.icu-project.org/repos/icu/icu4j/trunk"

#inherit java-pkg-2 java-ant-2 java-osgi
inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="ICU4J is a set of Java libraries providing Unicode and Globalization support."
MY_PV=${PV//./_}

#SRC_URI="http://download.icu-project.org/files/${PN}/${PV}/${PN}-${MY_PV}-src.jar
#	doc? ( http://download.icu-project.org/files/${PN}/${PV}/${PN}-${MY_PV}-docs.jar )"
HOMEPAGE="http://www.icu-project.org/"
LICENSE="icu"
SLOT="4.6"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"

RDEPEND=">=virtual/jre-1.6"

# build.xml does file version detection that fails for 1.7
# http://bugs.gentoo.org/show_bug.cgi?id=213555
DEPEND=">=virtual/jdk-1.6"

RESTRICT="ia64? ( test )
	x86-fbsd? ( test )"
JAVA_PKG_WANT_SOURCE="1.6"
JAVA_PKG_WANT_TARGET="1.6"
JAVA_PKG_BSFIX_NAME="build.xml common-targets.xml"

src_install() {
#	java-osgi_newjar-fromfile "${PN}.jar" "${FILESDIR}/icu4j-${PV}-manifest" \
#		"International Components for Unicode for Java (ICU4J)"
#	java-pkg_dojar "${PN}-charsets.jar"
#	java-pkg_dojar "${PN}-collate.jar"
#	java-pkg_dojar "${PN}-core.jar"
#	java-pkg_dojar "${PN}-translit.jar"
#	java-pkg_dojar "${PN}.jar"
#	java-pkg_dojar "localespi/${PN}-localespi.jar"

	java-pkg_dojar "${PN}-charset.jar"
	java-pkg_dojar "${PN}.jar"
	java-pkg_dojar "${PN}-localespi.jar"

	use doc && dohtml -r readme.html docs/*
	use source && java-pkg_dosrc main/classes/*/src/*
}

# Tests only work with JDK-1.6, severe out of memory problems appear with 1.5

src_test() {
	eant check
}
