# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

JAVA_PKG_IUSE="source doc"

inherit java-pkg-2 java-ant-2

DESCRIPTION="RelaxNG java datatype"
HOMEPAGE="http://jaxb.dev.java.net/"
#SRC_URI="http://java.net/projects/jaxb/sources/version1/content/trunk/jaxb-ri/tools/lib/src/relaxng.javadt.src.zip?rev=197"
SRC_URI="http://java.net/projects/jaxb/sources/version1/content/trunk/jaxb-ri/tools/lib/src/relaxng.javadt.src.zip"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEP="
	dev-java/relaxng-datatype"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

S="${WORKDIR}"

java_prepare() {
	mkdir -p "${S}"/{src/main/java,src/main/resources/META-INF/services,lib} || die

	mv ${WORKDIR}/com "${S}"/src/main/java
	cp ${FILESDIR}/org.relaxng.datatype.DatatypeLibraryFactory "${S}"/src/main/resources/META-INF/services
	cp ${FILESDIR}/gentoo-build.xml ${S}/build.xml

	cd ${S}
	java-pkg_jar-from --into lib relaxng-datatype
}

EANT_EXTRA_ARGS="-Dproject.name=relaxng.javadt"

src_install() {
	java-pkg_dojar target/relaxng.javadt.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
