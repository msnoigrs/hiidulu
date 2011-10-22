# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

#ECVS_SERVER="cvs.dev.java.net:/cvs"
#ECVS_MODULE="jaxb2-sources/xsom"
#ECVS_USER="guest"

#WANT_ANT_TASKS="ant-nodeps dev-java/relaxngcc:0"

#inherit cvs java-pkg-2 java-ant-2
inherit java-pkg-2 java-ant-2

DESCRIPTION="XML Schema Object Model (XSOM) is a Java library that allows applications to easily parse XML Schema documents and inspect information in them."
HOMEPAGE="http://xsom.java.net/"
SRC_URI="http://download.java.net/maven/2/com/sun/xsom/xsom/20110101-SNAPSHOT/xsom-20110101-SNAPSHOT-sources.jar"

LICENSE="|| ( CDDL GPL-2-sun-classpath-exception )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

COMMON_DEP="dev-java/relaxng-datatype"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
#	dev-java/javacc
#	dev-java/relaxngcc
#	dev-java/msv
#	dev-java/xsdlib
#	dev-java/package-rename-task

#S="${WORKDIR}/${ECVS_MODULE}"
S="${WORKDIR}"

#JAVA_PKG_BSFIX="off"

src_unpack() {
	cp "${FILESDIR}/build.xml" .
	#http://fisheye5.cenqua.com/browse/~raw,r=1.12/jaxb2-sources/xsom/SCD.jj
#	cp "${FILESDIR}/SCD.jj" .
	mkdir src
	cd src
	unpack ${A}
}

java_prepare() {
	#epatch ${FILESDIR}/relaxngcc-2.patch

	#find -depth -type d -name CVS -exec rm -rf {} \;
	#find -type f -name .cvsignore -delete
	#find -name '*.jar' -print -delete

	mkdir lib
	java-pkg_jar-from --into lib relaxng-datatype
#	java-pkg_jar-from --into lib --build-only javacc
#	java-pkg_jar-from --into lib --build-only relaxngcc
#	java-pkg_jar-from --into lib --build-only msv
#	java-pkg_jar-from --into lib --build-only xsdlib
	mkdir -p build/src
}

src_install() {
	java-pkg_dojar build/xsom.jar

	use doc && java-pkg_dojavadoc build/javadoc
	use source && java-pkg_dosrc src/*
}
