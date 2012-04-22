# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
#JAVA_PKG_IUSE="doc source test"
JAVA_PKG_IUSE="source test"

ESVN_REPO_URI="https://svn.apache.org/repos/asf/commons/proper/lang/branches/LANG_2_X"

inherit eutils subversion java-pkg-2 java-ant-2

DESCRIPTION="Commons components to manipulate core java classes"
HOMEPAGE="http://commons.apache.org/lang/"
#SRC_URI="mirror://apache/commons/lang/source/${P}-src.tar.gz"
SRC_URI=""
IUSE=""

DEPEND=">=virtual/jdk-1.5
	test? ( dev-java/ant-junit:0 )"
RDEPEND=">=virtual/jre-1.5"

LICENSE="Apache-2.0"
SLOT="2.1"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"

JAVA_ANT_ENCODING="ISO-8859-1"

java_prepare() {
	rm -rf src/main/java/org/apache/commons/lang/enum
#	#epatch ${FILESDIR}/BigDecimal-compareTo.patch
}

src_install() {
	java-pkg_newjar target/${PN}-2.7-SNAPSHOT.jar

	dodoc RELEASE-NOTES.txt NOTICE.txt || die
	dohtml *.html || die
#	use doc && java-pkg_dojavadoc target/docs/api
	use source && java-pkg_dosrc src/main/java/*
}
