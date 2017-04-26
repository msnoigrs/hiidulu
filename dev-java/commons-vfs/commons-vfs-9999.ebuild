# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/apache/commons-vfs.git"

JAVA_PKG_IUSE="doc source"

inherit git-r3 java-pkg-2 java-ant-2

DESCRIPTION="A single API for accessing various different file systems"
HOMEPAGE="http://commons.apache.org/vfs/"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"

CDEPEND="
	dev-java/ant-core:0
	dev-java/commons-collections:4
	dev-java/jcl-over-slf4j:0
	dev-java/commons-net:0
	dev-java/commons-httpclient:3
	dev-java/commons-compress:0
	dev-java/jackrabbit-webdav:0
	dev-java/jsch:0
	"

RDEPEND=">=virtual/jre-1.7
	${CDEPEND}"

DEPEND=">=virtual/jdk-1.7
	${CDEPEND}"

S="${WORKDIR}/${P}/core"

java_prepare() {
	#epatch "${FILESDIR}"/${PN}-2.0-incompatibility.patch
	sed -i -e 's/DomUtil.BUILDER_FACTORY.newDocumentBuilder().newDocument()/DomUtil.createDocument()/' src/main/java/org/apache/commons/vfs2/provider/webdav/ExceptionConverter.java
	sed -i -e 's/Iterator<DavProperty>/org.apache.jackrabbit.webdav.property.DavPropertyIterator/g' src/main/java/org/apache/commons/vfs2/provider/webdav/WebdavFileObject.java

	rm -rv src/main/java/org/apache/commons/vfs2/provider/hdfs

	cp "${FILESDIR}"/${PN}-2.0-build.xml build.xml || die

	java-ant_rewrite-classpath
	java-ant_ignore-system-classes
}

EANT_GENTOO_CLASSPATH="
	ant-core
	commons-collections-4
	jcl-over-slf4j
	commons-net
	commons-httpclient-3
	commons-compress
	jackrabbit-webdav
	jsch
"
EANT_EXTRA_ARGS="-Dlibdir=${T}"

# The build.xml is generated from maven and can't run the tests properly
# Use maven test to execute these manually but that means downloading deps from
# the internet. Also the tests need to login to some ftp servers and samba
# shares so I doubt they work for everyone.
#src_test() {
#	ANT_TASKS="ant-junit" eant test
#}

src_install() {
	java-pkg_newjar target/*.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java
}
