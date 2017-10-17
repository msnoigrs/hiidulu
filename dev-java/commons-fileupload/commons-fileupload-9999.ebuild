# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="doc source"
EGIT_REPO_URI="https://github.com/apache/commons-fileupload.git"

inherit git-r3 java-pkg-2 java-pkg-simple

DESCRIPTION="A Java library for adding robust, high-performance, file upload capability to your servlets and web applications."
HOMEPAGE="http://commons.apache.org/fileupload/"
SRC_URI=""
COMMON_DEPEND="dev-java/commons-io:1"
DEPEND=">=virtual/jdk-1.6
	java-virtuals/servlet-api:3.0
	dev-java/portletapi:2.0
	${COMMON_DEPEND}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEPEND}"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src/main/java"
JAVA_GENTOO_CLASSPATH="commons-io-1,servlet-api-3.0,portletapi-2.0"
