# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="http://svn.apache.org/repos/asf/xml/commons/trunk/java/external"

inherit java-pkg-2 java-ant-2 eutils subversion

DESCRIPTION="An Apache-hosted set of externally-defined standards interfaces, namely DOM, SAX, and JAXP."
HOMEPAGE="http://xml.apache.org/commons/"
#SRC_URI="mirror://apache/xerces/xml-commons/source/${P}-src.tar.gz"
# upstream source tar.gz is missing build.xml and other stuff, so we get it like this
# svn export http://svn.apache.org/repos/asf/xml/commons/trunk/java/external/ xml-commons-external-1.4.01
# tar cjf xml-commons-external-1.4.01.tar.bz2 xml-commons-external-1.4.01

LICENSE="Apache-2.0"
SLOT="1.4"
KEYWORDS="amd64 ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

#S="${WORKDIR}"

#java_prepare() {
#	epatch "${FILESDIR}/svn-20110103.patch"
#	cp ${FILESDIR}/build.xml build.xml
#}

src_install() {
	java-pkg_dojar build/xml-apis.jar build/xml-apis-ext.jar

	#dodoc NOTICE README.* || die

	if use doc; then
		java-pkg_dojavadoc build/docs/javadoc
		java-pkg_dohtml -r build/docs/dom
	fi
	use source && java-pkg_dosrc src/javax src/org
}
