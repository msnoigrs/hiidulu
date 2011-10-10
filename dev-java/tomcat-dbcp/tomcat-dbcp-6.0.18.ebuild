# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

ESVN_REPO_URI="http://svn.apache.org/repos/asf/commons/proper/dbcp/trunk"
COMMONS_POOL_VER="1.4"

inherit subversion eutils java-pkg-2 java-ant-2

DESCRIPTION="Tomcat dbcp"
SRC_URI="mirror://apache/commons/pool/source/commons-pool-${COMMONS_POOL_VER}-src.tar.gz"
HOMEPAGE="http://tomcat.apache.org/"

LICENSE="Apache-2.0"
SLOT="6"
KEYWORDS="~x86 ~amd64"

IUSE="java6"

CDEPEND="dev-java/geronimo-spec-jta"
DEPEND="!java6? ( =virtual/jdk-1.5* )
	java6? ( >=virtual/jdk-1.6 )
	${CDEPEND}"
RDEPEND="!java6? ( =virtual/jre-1.5* )
	java6? ( >=virtual/jre-1.6 )
	${CDEPEND}"

MY_S="${S}"
S_DBCP="${S}/commons-dbcp-9999-src"
S_POOL="${S}/commons-pool-${COMMONS_POOL_VER}-src"

src_unpack() {
	S="${S_DBCP}"
	subversion_src_unpack
	S="${MY_S}"
#	if use java6; then
#		epatch "${FILESDIR}/jdbc4.patch"
#	fi
	cd "${S}"
	unpack "${A}"
	cd "${S}"
	cp "${FILESDIR}/${PN}-build.xml" build.xml
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
	java-pkg_dojar "${T}/tomcat6-deps/dbcp/${PN}.jar"
}
