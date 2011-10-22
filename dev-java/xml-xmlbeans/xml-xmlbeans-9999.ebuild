# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-nodeps"
ESVN_REPO_URI="http://svn.apache.org/repos/asf/xmlbeans/trunk"

inherit subversion java-pkg-2 java-ant-2

#MY_PN="xmlbeans"
#MY_P="${MY_PN}-${PV}"

DESCRIPTION="A XML-Java binding tool"
#SRC_URI="mirror://apache/xmlbeans/source/${MY_P}-src.tgz"
SRC_URI=""
HOMEPAGE="http://xmlbeans.apache.org/"
LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="dev-java/xml-commons-resolver
	dev-java/saxon:9
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"

java_prepare() {
	rm -fv external/lib/junit.jar

	sed -i -e 's/, jsr173_1.0.jars"/"/g' \
		-e 's/,jsr173_1.0.jars"/"/g' \
		-e 's/, jsr173_1.0.jars,/,/g' \
		-e 's/, resolver.jar,/,/' \
		build.xml

	mkdir -p build/lib
#	java-pkg_jar-from --build-only --into build/lib jsr173 jsr173.jar jsr173_1.0_api.jar
	java-pkg_jar-from --into build/lib saxon-9 saxon9.jar
	java-pkg_jar-from --into build/lib saxon-9 saxon9-dom.jar
	java-pkg_jar-from --into build/lib xml-commons-resolver xml-commons-resolver.jar resolver.jar
}

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_BUILD_TARGET="deploy"
EANT_DOC_TARGET="docs"
JAVA_ANT_ENCODING="iso-8859-1"

src_compile() {
	EANT_EXTRA_ARGS="-Dgentoo.classpath=$(java-config -t):$(java-pkg_getjar ant-core ant.jar)" \
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar build/lib/xbean*.jar
	java-pkg_dojar build/lib/xml*.jar

	java-pkg_register-ant-task

	newbin ${FILESDIR}/cmd.script dumpxsdb-${SLOT}
	newbin ${FILESDIR}/cmd.script inst2xsd-${SLOT}
	newbin ${FILESDIR}/cmd.script scomp-${SLOT}
	newbin ${FILESDIR}/cmd.script scopy-${SLOT}
	newbin ${FILESDIR}/cmd.script sdownload-${SLOT}
	newbin ${FILESDIR}/cmd.script sfactor-${SLOT}
	newbin ${FILESDIR}/cmd.script svalidate-${SLOT}
	newbin ${FILESDIR}/cmd.script validate-${SLOT}
	newbin ${FILESDIR}/cmd.script xpretty-${SLOT}
	newbin ${FILESDIR}/cmd.script xsd2inst-${SLOT}
	newbin ${FILESDIR}/cmd.script xsdtree-${SLOT}
	newbin ${FILESDIR}/cmd.script xstc-${SLOT}

	dodoc NOTICE.txt README.txt

	use doc && java-pkg_dohtml -r build/docs/*
	use source && java-pkg_dosrc src/*
}
