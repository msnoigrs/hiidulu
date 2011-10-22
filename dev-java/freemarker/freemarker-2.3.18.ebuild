# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source +xalan +dom log4j +slf4j +commonslogging jython javarebel"
#JAVA_PKG_IUSE="doc source +xalan +dom +log4j logkit jython rhino javarebel"
WANT_ANT_TASKS="ant-nodeps"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION=" FreeMarker is a template engine; a generic tool to generate text output based on templates."
HOMEPAGE="http://freemarker.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="freemarker"
SLOT="2.3"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

#	dev-java/el-api
COMMON_DEP="
	java-virtuals/servlet-api:3.0
	xalan? ( dev-java/xalan:0 )
	dom? ( dev-java/dom4j:1
		dev-java/jaxen:1.1
		dev-java/jaxen-dom4j:1.1 )
	log4j? ( dev-java/log4j-over-slf4j )
	slf4j? ( dev-java/slf4j-api )
	commonslogging? ( dev-java/jcl-over-slf4j )
	jython? ( dev-java/jython:0 )"
#		dev-java/jdom:1.0
#		dev-java/jaxen-jdom:1.1 )"
#	logkit? ( dev-java/avalon-logkit:2.0 )
DEPEND=">=virtual/jdk-1.5
	dev-java/javacc
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

JAVA_ANT_ENCODING="iso-8859-1"

#JAVA_PKG_BSFIX="off"

java_prepare() {
	epatch ${FILESDIR}/${PN}-2.3.18-build.patch

	find -name '*.jar' -exec rm -v {} \;

	java-pkg_jar-from --into lib --build-only javacc javacc.jar
	java-pkg_jar-from --into lib --virtual servlet-api-3.0 servlet-api.jar servlet.jar
	java-pkg_jar-from --into lib --virtual servlet-api-3.0 jsp-api.jar jsp-api-2.1.jar
	java-pkg_jar-from --into lib --virtual servlet-api-3.0 el-api.jar el-api.jar
#	java-pkg_jar-from --into lib el-api el-api.jar
	if use xalan; then
		java-pkg_jar-from --into lib xalan xalan.jar
	fi
	if use dom; then
		java-pkg_jar-from --into lib dom4j-1 dom4j.jar
#		java-pkg_jar-from --into lib jdom-1.0 jdom.jar
		java-pkg_jar-from --into lib jaxen-1.1 jaxen.jar
		java-pkg_jar-from --into lib jaxen-dom4j-1.1 jaxen-dom4j.jar
#		java-pkg_jar-from --into lib jaxen-jdom-1.1 jaxen-jdom.jar
	fi
	if use log4j; then
		java-pkg_jar-from --into lib log4j-over-slf4j log4j-over-slf4j.jar log4j.jar
	fi
	if use slf4j; then
		java-pkg_jar-from --into lib slf4j-api slf4j-api.jar
	fi
	if use commonslogging; then
		java-pkg_jar-from --into lib jcl-over-slf4j jcl-over-slf4j.jar commons-logging.jar
	fi
	if use jython; then
		#java-pkg_jar-from --into lib jython jython.jar
		:
	else
		epatch ${FILESDIR}/2.3.15-jython-nodep.patch
	fi
	if ! use javarebel; then
		# remove JavaRebel dependency
		rm -v src/freemarker/ext/beans/JavaRebelIntegration.java || die
		epatch ${FILESDIR}/freemarker-2.3.18-JavaRebel-nodep.patch
	fi
}

EANT_BUILD_TARGET="clean jar"
EANT_EXTRA_ARGS="-Djavacc.home=/usr/share/javacc/lib"

src_install() {
	java-pkg_dojar lib/${PN}.jar
	dodoc README.txt || die

	use doc && java-pkg_dojavadoc build/api
	use source && java-pkg_dosrc src/*
}
