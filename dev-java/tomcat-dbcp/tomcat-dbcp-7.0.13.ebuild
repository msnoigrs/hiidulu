# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"
#ESVN_REPO_URI="dummy"
#ESVN_REPO_URI="http://svn.apache.org/repos/asf/commons/proper/dbcp/trunk"
COMMONS_DBCP_VER="1.4"
COMMONS_POOL_VER="1.5.6"

#inherit java-pkg-2 java-ant-2 subversion
inherit java-pkg-2 java-ant-2

DESCRIPTION="Tomcat dbcp"
SRC_URI="mirror://apache/commons/pool/source/commons-pool-${COMMONS_POOL_VER}-src.tar.gz
mirror://apache/commons/dbcp/source/commons-dbcp-${COMMONS_DBCP_VER}-src.tar.gz"
#SRC_URI=""
HOMEPAGE="http://tomcat.apache.org/"

LICENSE="Apache-2.0"
SLOT="7"
KEYWORDS="~x86 ~amd64"

IUSE=""

CDEPEND="dev-java/geronimo-spec-jta"
DEPEND=">=virtual/jdk-1.6
	${CDEPEND}"
RDEPEND=">=virtual/jre-1.6
	${CDEPEND}"

S="${WORKDIR}"
#S_DBCP="${S}/commons-dbcp-9999-src"
S_DBCP="${S}/commons-dbcp-${COMMONS_DBCP_VER}-src"
#S_POOL="${S}/commons-pool-9999-src"
S_POOL="${S}/commons-pool-${COMMONS_POOL_VER}-src"


java_prepare() {
	epatch "${FILESDIR}"/commons-dbcp-1.4.x.patch
	cp "${FILESDIR}/${PN}-7-build.xml" build.xml
}

src_compile() {
	local antflags="-Dbase.path=${T}"
	antflags="${antflags} -Dcompile.debug=false"
	antflags="${antflags} -Dcommons-pool.home=${S_POOL}"
	antflags="${antflags} -Dcommons-dbcp.home=${S_DBCP}"
	antflags="${antflags} -Djta-spec.jar=$(java-pkg_getjars geronimo-spec-jta)"
	eant ${antflags}
}

src_install() {
	java-pkg_dojar "${T}/tomcat7-deps/dbcp/${PN}.jar"
}
