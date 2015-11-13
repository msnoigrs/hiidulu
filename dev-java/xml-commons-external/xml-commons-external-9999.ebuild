# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="http://svn.apache.org/repos/asf/xerces/xml-commons/trunk/java/external"

inherit subversion eutils java-pkg-2 java-ant-2

DESCRIPTION="An Apache-hosted set of externally-defined standards interfaces, namely DOM, SAX, and JAXP."
HOMEPAGE="http://xml.apache.org/commons/"

LICENSE="Apache-2.0"
SLOT="1.4"
KEYWORDS="amd64 ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

src_install() {
	java-pkg_dojar build/xml-apis.jar build/xml-apis-ext.jar

	#dodoc NOTICE README.* || die

	if use doc; then
		java-pkg_dojavadoc build/docs/javadoc
		java-pkg_dohtml -r build/docs/dom
	fi
	use source && java-pkg_dosrc src/javax src/org
}
