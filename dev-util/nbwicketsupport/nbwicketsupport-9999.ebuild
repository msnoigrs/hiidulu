# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
WICKET_VER="6.5.0"

JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="https://svn.java.net/svn/nbwicketsupport~nbwicketsupport"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Sun DTDParser"
HOMEPAGE="http://netbeans.org/kb/docs/web/quickstart-webapps-wicket.html"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"

IUSE=""

COMMON_DEP="dev-util/netbeans
	dev-java/slf4j-api
	dev-java/slf4j-jdk14
	=dev-java/wicket-core-${WICKET_VER}:6.5
	=dev-java/wicket-devutils-${WICKET_VER}:6.5
	=dev-java/wicket-extensions-${WICKET_VER}:6.5
	=dev-java/wicket-ioc-${WICKET_VER}:6.5
	=dev-java/wicket-request-${WICKET_VER}:6.5
	=dev-java/wicket-util-${WICKET_VER}:6.5"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"

java_prepare() {
	rm -fv updates/*

	epatch "${FILESDIR}/wicket650.patch"
	epatch "${FILESDIR}/build.patch"

	mkdir -p WicketSuite/WicketLibraries6.5.0/release/libs
	cd WicketSuite/WicketLibraries6.5.0/release/libs

	java-pkg_jar-from slf4j-api slf4j-api.jar slf4j-api-1.7.2.jar
	java-pkg_jar-from slf4j-jdk14 slf4j-jdk14.jar slf4j-jdk14-1.7.2.jar
	java-pkg_jar-from wicket-core-6.5 wicket-core.jar wicket-core-${WICKET_VER}.jar
	java-pkg_jar-from wicket-devutils-6.5 wicket-devutils.jar wicket-devutils-${WICKET_VER}.jar
	java-pkg_jar-from wicket-extensions-6.5 wicket-extensions.jar wicket-extensions-${WICKET_VER}.jar
	java-pkg_jar-from wicket-ioc-6.5 wicket-ioc.jar wicket-ioc-${WICKET_VER}.jar
	java-pkg_jar-from wicket-request-6.5 wicket-request.jar wicket-request-${WICKET_VER}.jar
	java-pkg_jar-from wicket-util-6.5 wicket-util.jar wicket-util-${WICKET_VER}.jar

	cd "${S}"
	sed -i -e 's/1.5/1.6/' WicketSuite/WicketCore/nbproject/project.properties \
		WicketSuite/WicketFileTemplates/nbproject/project.properties \
		WicketSuite/WicketLibraries6.5.0/nbproject/project.properties
}

JAVA_PKG_BSFIX="off"
EANT_BUILD_TARGET="nbms"
EANT_EXTRA_ARGS="-v -Dnbplatform.active.dir=/usr/share/netbeans-nb-7.2 -Dharness.dir=/usr/share/netbeans-nb-7.2/harness -Ddisabled.modules="
src_compile() {
	cd WicketSuite

	java-pkg-2_src_compile
}

src_install() {
	insinto /usr/share/${PN}
	doins -r WicketSuite/build/updates/licenses
	doins WicketSuite/build/updates/updates.xml
	doins WicketSuite/build/updates/org-apache-wicket.nbm
	doins WicketSuite/build/updates/org-netbeans-modules-web-wicket.nbm
	doins WicketSuite/build/updates/org-netbeans-modules-wicket-templates.nbm
}
