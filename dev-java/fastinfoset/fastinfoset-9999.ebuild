# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="source"

ESVN_REPO_URI="https://svn.java.net/svn/fi~svn/trunk/code/${PN}"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Fast Infoset"
HOMEPAGE="http://fi.java.net/"
#SRC_URI="https://fi.dev.java.net/files/documents/2634/136954/FastInfosetPackage_src_${PV}.zip"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

# for utilities
COMMON_DEP="java-virtuals/stax-api"
#	dev-java/xsom
#	dev-java/xmlstreambuffer"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"

#S="${WORKDIR}"

java_prepare() {
	find -name '*.jar' -print -delete

	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir lib

	java-pkg_jar-from --into lib --virtual stax-api

#	find -name '*.class' -print -delete

#	sed -i -e 's/_eiiStateTable\[item\]/getEIIState(item)/g' \
#		-e 's/_eiiStateTable\[readStructure()\]/getEIIState(readStructure())/' \
#		-e 's/_niiStateTable\[item\]/getNIIState(item)/' \
#		-e 's/_aiiStateTable\[item\]/getAIIState(item)/' \
#		FastInfosetUtilities/src/com/sun/xml/fastinfoset/streambuffer/FastInfosetWriterSAXBufferProcessor.java || die
#
#	java-pkg_jar-from --into ${S}/FastInfoset/lib --virtual stax-api
#	java-pkg_jar-from --into ${S}/FastInfosetUtilities/lib xsom
#	java-pkg_jar-from --into ${S}/FastInfosetUtilities/lib xmlstreambuffer
#
#	java-ant_bsfix_one ${S}/FastInfoset/nbproject/build-impl.xml
#	java-ant_bsfix_one ${S}/FastInfosetUtilities/nbproject/build-impl.xml
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

#src_compile() {
#	cd ${S}/FastInfoset
#	java-pkg-2_src_compile
#	cd ${S}/FastInfosetUtilities
#	java-pkg-2_src_compile
#}

src_install() {
#	java-pkg_dojar FastInfoset/dist/FastInfoset.jar
#	java-pkg_dojar FastInfosetUtilities/dist/FastInfosetUtilities.jar
#	if use source; then
#		java-pkg_dosrc FastInfoset/src/*
#		java-pkg_dosrc FastInfosetUtilities/src/*
#	fi
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
