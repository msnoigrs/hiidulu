# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

JAVA_PKG_IUSE="doc source"

inherit cvs java-pkg-2 eutils java-ant-2

ECVS_SERVER="xmldb-org.cvs.sourceforge.net:/cvsroot/xmldb-org"
ECVS_MODULE="xapi/src"
ECVS_CO_OPTS="-D 2004-08-01"
ECVS_UP_OPTS="-D 2004-08-01 -dP"

#MY_PN="${PN}-api"
#MY_PV="11112001"
#MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="Java implementation for specifications made by XML:DB."
HOMEPAGE="http://sourceforge.net/projects/xmldb-org/"
#SRC_URI="mirror://sourceforge/xmldb-org/${MY_P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

# TODO please make compiling the junit tests optional
COMMON_DEP="
	>=dev-java/xerces-2.7
	>=dev-java/xalan-2.7
	=dev-java/junit-3.8*"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

S="${WORKDIR}/${ECVS_MODULE}"

JAVA_PKG_BSFIX_NAME="build.xml buildCommon.xml"

java_prepare() {
	sed -i -e 's/ enum/ xenum/g' api/org/xmldb/api/sdk/modules/SetContentHandler.java || die

	find . -name CVS -type d -depth -exec rm -rf {} \;

	#rm -v *.jar || die
	#mkdir lib
	rm lib/*.jar
	cd lib
	java-pkg_jarfrom xalan xalan.jar
	java-pkg_jarfrom xerces-2 xercesImpl.jar xerces.jar
	java-pkg_jarfrom junit junit.jar

	#epatch "${FILESDIR}/${P}-unreachable.patch"

	#mkdir src && mv org src
	#cp "${FILESDIR}/build-${PV}.xml" build.xml
}

src_compile() {
	# --with-dependencies because of indirectly referenced xml-commons-external
	#eant jar $(use_doc) \
	#	-Dclasspath=$(java-pkg_getjars --with-dependencies xerces-2,xalan,junit)
	#eant -f buildCommon.xml package.common
	eant bin-jar bin-jar-sdk $(use_doc)
}

src_install() {
	java-pkg_dojar build/jar/*.jar

	use doc && java-pkg_dojavadoc build/javadoc/full
	use source && java-pkg_dosrc api/org
}
