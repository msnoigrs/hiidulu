# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc source"

EGIT_BRANCH="vfs-1-trunk"
EGIT_REPO_URI="https://github.com/apache/commons-vfs.git"

inherit git-r3 java-pkg-2 java-ant-2

DESCRIPTION="a single API for accessing various different file systems"
HOMEPAGE="http://jakarta.apache.org/commons/vfs/"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEP="
	dev-java/commons-net:0
	dev-java/commons-httpclient:3
	dev-java/commons-collections:4
	dev-java/jsch
	dev-java/jcl-over-slf4j
"

RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	dev-java/ant-core
	${COMMON_DEP}"

java_prepare() {
	sed -i -e 's/depends="get-deps"//g' build.xml

	# see http://issues.apache.org/jira/browse/VFS-74
	epatch ${FILESDIR}/${PN}-httpclient-compat.patch

	sed -i -e 's/org.apache.commons.collections.map.AbstractLinkedMap/org.apache.commons.collections4.map.AbstractLinkedMap/' \
		-e 's/org.apache.commons.collections.map.LRUMap/org.apache.commons.collections4.map.LRUMap/' \
		core/src/main/java/org/apache/commons/vfs/cache/LRUFilesCache.java

	java-ant_rewrite-classpath
	java-ant_ignore-system-classes

	cd ${S}/sandbox
	java-ant_rewrite-classpath
	java-ant_ignore-system-classes
}

src_compile() {
	local cp="$(java-pkg_getjar --build-only ant-core ant.jar)"
	cp="${cp}:$(java-pkg_getjars commons-httpclient-3)"
	cp="${cp}:$(java-pkg_getjars commons-collections-4)"
	cp="${cp}:$(java-pkg_getjars commons-net)"
	cp="${cp}:$(java-pkg_getjars jsch)"
	cp="${cp}:$(java-pkg_getjars jcl-over-slf4j)"
	eant -Dgentoo.classpath=${cp} -Dlibdir=${T} jar $(use_doc)
}

# The build.xml is generated from maven and can't run the tests properly
# Use maven test to execute these manually but that means downloading deps from
# the internet. Also the tests need to login to some ftp servers and samba
# shares so I doubt they work for everyone.
#src_test() {
#	ANT_TASKS="ant-junit" eant test
#}

src_install() {
	java-pkg_newjar target/${PN}*.jar
	java-pkg_register-ant-task
	dodoc *.txt || die
	use doc && java-pkg_dojavadoc ./dist/docs/api
	use source && java-pkg_dosrc ./core/src/main/java
}
