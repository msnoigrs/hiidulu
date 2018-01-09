# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

JAVA_PKG_IUSE="source"

JAVA_PKG_BSFIX_NAME="build.xml osbuild.xml"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Quartz Scheduler"
HOMEPAGE="http://www.quartz-scheduler.org/"
SRC_URI="http://d2zwv9pap9ylyd.cloudfront.net/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="1.6"
KEYWORDS="~amd64 ~ppc ~x86"

COMMON_DEPEND="dev-java/commons-collections
		dev-java/jcl-over-slf4j:0
		dev-java/commons-beanutils
		dev-java/commons-dbcp
		>=dev-java/commons-digester-1.7
		dev-java/commons-modeler
		dev-java/geronimo-spec-jta
		dev-java/oracle-javamail
		dev-java/geronimo-spec-jms"
#		dev-java/sun-ejb"

#		test? ( dev-java/junit )
#		oracle? ( =dev-java/jdbc-oracle-bin-9.2* )
#		jboss? ( >=www-servers/jboss-3.2.3 )

RDEPEND=">=virtual/jre-1.6
	${COMMON_DEPEND}"

DEPEND=">=virtual/jdk-1.6
	java-virtuals/servlet-api:3.0
	dev-java/geronimo-spec-ejb
	${COMMON_DEPEND}
	app-arch/unzip"

#S="${WORKDIR}"

src_prepare() {
	echo "Removing bundled jars"
	find -name '*.jar' -exec rm -v {} \;

#	epatch "${FILESDIR}/cp.patch"

	cd "${S}/lib"
	java-pkg_jar-from jcl-over-slf4j jcl-over-slf4j.jar commons-logging.jar
	java-pkg_jar-from commons-beanutils-1.7
	java-pkg_jar-from commons-dbcp
	java-pkg_jar-from commons-digester
	java-pkg_jar-from commons-modeler
	java-pkg_jar-from geronimo-spec-jta
#	java-pkg_jar-from sun-ejb-3.0
	java-pkg_jar-from oracle-javamail
	java-pkg_jar-from geronimo-spec-jms
	java-pkg_jar-from --virtual --build-only servlet-api-3.0 servlet-api.jar
	java-pkg_jar-from --build-only geronimo-spec-ejb
}

EANT_EXTRA_ARTS="-Dskip.checkstype=true"

#src_compile() {
#	eant -Dskip.checkstyle=true jar
#}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar
	java-pkg_newjar build/${PN}-all-${PV}.jar ${PN}-all.jar

	use source && java-pkg_dosrc src/*
}
