# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="http://svn.apache.org/repos/asf/pdfbox/trunk/jempbox"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="An open source Java XMP library"
HOMEPAGE="http://pdfbox.apache.org/"

LICENSE="Apache-2.0"
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
