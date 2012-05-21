# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/quartz/quartz-1.4.5.ebuild,v 1.4 2005/10/15 11:41:22 axxo Exp $

JAVA_PKG_IUSE="source"

JAVA_PKG_BSFIX_NAME="build.xml osbuild.xml"

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="Quartz Scheduler from OpenSymphony"
HOMEPAGE="http://www.opensymphony.com/quartz/"
SRC_URI="https://quartz.dev.java.net/files/documents/1267/43545/${P}.zip"

LICENSE="Apache-2.0"
SLOT="1.6"
KEYWORDS="~amd64 ~ppc ~x86"

COMMON_DEPEND="dev-java/commons-collections
		dev-java/commons-logging
		dev-java/commons-beanutils
		dev-java/commons-dbcp
		>=dev-java/commons-digester-1.7
		dev-java/commons-modeler
		dev-java/jta
		dev-java/sun-javamail
		dev-java/sun-jms
		dev-java/sun-ejb"

#		test? ( dev-java/junit )
#		oracle? ( =dev-java/jdbc-oracle-bin-9.2* )
#		jboss? ( >=www-servers/jboss-3.2.3 )

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEPEND}"

DEPEND=">=virtual/jdk-1.5
	${COMMON_DEPEND}
	app-arch/unzip"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo "Removing bundled jars"
	find -name '*.jar' -exec rm -v {} \;

	epatch "${FILESDIR}/cp.patch"

	cd "${S}/lib"
	java-pkg_jar-from commons-logging
	java-pkg_jar-from commons-beanutils-1.7
	java-pkg_jar-from commons-dbcp
	java-pkg_jar-from commons-digester
	java-pkg_jar-from commons-modeler
	java-pkg_jar-from jta
	java-pkg_jar-from sun-ejb-3.0
	java-pkg_jar-from sun-javamail
	java-pkg_jar-from sun-jms
}

src_compile() {
	eant -Dskip.checkstyle=true jar
}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar
	java-pkg_newjar build/${PN}-all-${PV}.jar ${PN}-all.jar

	use source && java-pkg_dosrc src/*
}
