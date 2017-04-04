# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="doc source"

EGIT_REPO_URI="https://github.com/svn2github/xerces-xml-commons"

inherit git-r3 java-pkg-2 java-ant-2

DESCRIPTION="An XML Entity and URI Resolver"
HOMEPAGE="http://xml.apache.org/commons/"
#SRC_URI="mirror://apache/xml/commons/${P}.tar.gz"
#http://svn.apache.org/repos/asf/xml/commons/trunk/java/src/org/apache/xml/resolver/
DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

JAVA_PKG_BSFIX_NAME="resolver.xml"

S="${WORKDIR}/${P}/java"

src_unpack() {
	git-r3_src_unpack

	cd ${S}
	rm -r external
	rm which.xml
	rm src/manifest.which
	rm -r src/org/apache/env
}

java_prepare() {
	# https://issues.apache.org/bugzilla/show_bug.cgi?id=44582
	epatch "${FILESDIR}/9999-add-getPublicIds.patch"
	# with jaxb-2.1.10 and netbeans
	epatch "${FILESDIR}/9999-handle-null-readProperties.patch"
	# with netbeans
	epatch "${FILESDIR}/9999-resolver.patch"
	epatch "${FILESDIR}/9999-catalog.diff"
	# see http://patch-tracker.debian.org/package/libxml-commons-resolver1.1-java/1.2-5
	# needed by netbeans 6.7
	cd ${WORKDIR}
	epatch "${FILESDIR}/nb-extra-9999.patch"

	rm -rf apidocs resolver.jar || die
}

EANT_BUILD_XML="resolver.xml"
EANT_DOC_TARGET="javadocs"

src_install() {
	java-pkg_newjar build/resolver.jar

	if use doc; then
		java-pkg_dojavadoc build/apidocs/resolver
		java-pkg_dohtml docs/*.html
	fi

	use source && java-pkg_dosrc src/org
}
