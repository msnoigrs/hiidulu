# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/antlibs/ant-contrib.git"

JAVA_PKG_IUSE="doc source"

inherit git-r3 java-pkg-2 java-pkg-simple

DESCRIPTION="The Ant-Contrib project is a collection of tasks (and at one point maybe types and other tools) for Apache Ant."
HOMEPAGE="http://ant-contrib.sourceforge.net/"
#SRC_URI=""
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.6
	>=dev-java/bcel-5.1:0
	dev-java/commons-httpclient:3
	dev-java/ant-ivy:2"
DEPEND=">=virtual/jdk-1.6
	dev-java/ant-ivy:0
	>=dev-java/ant-core-1.7.0
	${RDEPEND}"

S="${WORKDIR}/${P}"
JAVA_SRC_DIR="src/main/java"
JAVA_GENTOO_CLASSPATH="ant-core,commons-httpclient-3,bcel,ant-ivy-2,ant-ivy"

java_prepare() {
	cp ${FILESDIR}/antcontrib.properties src/main/resources/net/sf/antcontrib
}


src_compile() {
	java-pkg-simple_src_compile
	java-pkg_addres ${PN}.jar src/main/resources
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_register-ant-task
}
