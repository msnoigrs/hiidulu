# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public Licnese v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="source"

ESVN_REPO_URI="https://svn.java.net/svn/mimepull~svn/trunk"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="A streaming API to access attachments parts in a MIME message"
HOMEPAGE="http://mimepull.java.net/"
SRC_URI=""

LICENSE="|| ( CDDL GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
