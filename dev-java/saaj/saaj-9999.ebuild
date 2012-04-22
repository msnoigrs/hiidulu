# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="source"

ESVN_REPO_URI="https://svn.java.net/svn/saaj~svn/trunk/saaj-ri"
# 1.3.9
inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="SOAP with Attachments API for Java"
HOMEPAGE="http://java.net/projects/saaj/"
SRC_URI=""

LICENSE="CDDL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="java-virtuals/saaj-api
	java-virtuals/jaf
	dev-java/mimepull
	dev-java/xml-commons-external:1.4
	>=dev-java/xerces-2.8"
# needs com.sun.image.codec which 1.7 doesn't have
# should fix it to not use them at all
DEPEND="|| ( =virtual/jdk-1.6* =virtual/jdk-1.5* )
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

java_prepare() {
	find -name '*.jar' -delete

	epatch "${FILESDIR}/build.patch"

	mkdir lib/endorsed || die

	cd "${S}/lib"
	java-pkg_jar-from --virtual saaj-api
	java-pkg_jar-from --virtual jaf
	java-pkg_jar-from mimepull
	java-pkg_jar-from xerces-2
	java-pkg_jar-from --into endorsed xml-commons-external-1.4
#	java-pkg_jar-from xalan

#	cp -i "${FILESDIR}/build-9999.xml" "${S}/build.xml" || die

	cd "${S}/src/java"
	# YES! There's nothing like using com.sun...internal ! YAY!
	find . -name '*.java' -exec sed -i \
		-e 's/com.sun.org.apache.xerces.internal/org.apache.xerces/g' \
		{} \;
}

src_install() {
	java-pkg_dojar build/lib/saaj-impl.jar

	use source && java-pkg_dosrc src/java/*
}
