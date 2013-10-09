# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit subversion java-pkg-2 java-ant-2

#ESVN_OPTIONS="-r${PV/*_pre}"
ESVN_REPO_URI="http://svn.apache.org/repos/asf/commons/proper/vfs/branches/vfs-1-trunk"

DESCRIPTION="a single API for accessing various different file systems"
HOMEPAGE="http://jakarta.apache.org/commons/vfs/"
#SRC_URI="mirror://apache/jakarta/${PN/-//}/source/${P}-src.tar.gz"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEP="
	dev-java/commons-net:0
	dev-java/commons-httpclient:3
	dev-java/commons-collections
	dev-java/jsch
	dev-java/jcl-over-slf4j
"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	dev-java/ant-core
	${COMMON_DEP}"

java_prepare() {
	sed -i -e 's/depends="get-deps"//' build.xml

	# see http://issues.apache.org/jira/browse/VFS-74
	epatch ${FILESDIR}/${PN}-httpclient-compat.patch

	java-ant_rewrite-classpath
	java-ant_ignore-system-classes

	cd ${S}/sandbox
	java-ant_rewrite-classpath
	java-ant_ignore-system-classes
}

src_compile() {
	local cp="$(java-pkg_getjar --build-only ant-core ant.jar)"
	cp="${cp}:$(java-pkg_getjars commons-httpclient-3)"
	cp="${cp}:$(java-pkg_getjars commons-collections)"
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
