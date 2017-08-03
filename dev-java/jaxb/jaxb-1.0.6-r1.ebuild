# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

ESVN_REPO_URI="https://svn.java.net/svn/jaxb~version1/trunk/jaxb-ri"

#JAVA_PKG_IUSE="source"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Reference implementation of the JAXB specification."
HOMEPAGE="http://jaxb.dev.java.net/"
#SRC_URI="mirror://gentoo/${PN}-src-${PV}.zip"
#SRC_URI="${PN}-src-${PV}.tar.bz2"
# svn export https://svn.java.net/svn/jaxb~version1/trunk/jaxb-ri jaxb-ri-1.0.6
MY_TARBALL="${PN}-ri-${PV}.tar.gz"
SRC_URI="https://osdn.net/frs/chamber_redir.php?m=iij&f=%2Fusers%2F13%2F13650%2F${MY_TARBALL} -> ${MY_TARBALL}"

LICENSE="|| ( CDDL GPL-2-with-lonking-exception )"
SLOT="1"
KEYWORDS="~x86 ~amd64"
IUSE=""

#dev-java/codemodel:2
COMMON_DEP="
	dev-java/dom4j:1
	dev-java/iso-relax
	dev-java/msv
	dev-java/relaxng-datatype
	dev-java/relaxng-javadt
	dev-java/xalan
	dev-java/xerces:2
	dev-java/xml-commons-resolver
	dev-java/xsdlib
	dev-java/xsom"
DEPEND=">=virtual/jdk-1.6
	dev-java/ant-core
	dev-java/relaxngcc
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

#S="${WORKDIR}/jaxb-ri-${PV}"

java_prepare() {
#	rm -rf codemodel/*

	rm -v tools/lib/rebundle/msv.jar || die
	rm -v tools/lib/rebundle/isorelax.jar || die
	rm -v tools/lib/rebundle/xsom.jar || die
	rm -v tools/lib/rebundle/resolver.jar || die
	rm -v tools/lib/rebundle/relaxng.javadt.jar || die
	rm -v tools/lib/redist/*.jar || die
	rm -v tools/lib/util/*.jar || die

	cd ${S}/tools/lib/rebundle
	java-pkg_jarfrom msv
	java-pkg_jarfrom iso-relax
	java-pkg_jarfrom xsom
	java-pkg_jarfrom xml-commons-resolver xml-commons-resolver.jar resolver.jar
	java-pkg_jarfrom relaxng-javadt
#	java-pkg_jarfrom codemodel-2

	cd ${S}/tools/lib/redist
	java-pkg_jarfrom xsdlib
	java-pkg_jarfrom xerces-2
	java-pkg_jarfrom relaxng-datatype
	java-pkg_jarfrom xalan xalan.jar
	java-pkg_jarfrom --build-only ant-core ant.jar

	cd ${S}/tools/lib/util
	java-pkg_jarfrom dom4j-1
	java-pkg_jarfrom --build-only relaxngcc
#	java-pkg_jarfrom --build-only --virtual servlet-api-3.0 servlet-api.jar servlet.jar

	cd ${S}

	epatch "${FILESDIR}"/1.0.6-build-gentoo-3.patch
	epatch "${FILESDIR}"/1.0.6-build-gentoo-2.patch
	epatch "${FILESDIR}"/1.0.6-build-gentoo.patch

	epatch "${FILESDIR}"/${PV}-resolver-1.2.patch
	epatch "${FILESDIR}"/${PV}-xsom-20060901.patch
#	epatch ${FILESDIR}/${PV}-codemodel-2.1.patch
#	epatch ${FILESDIR}/${PV}-META-INF.patch

	cd ${S}
	sed -i -e 's/com.sun.org.apache.xerces.internal/org.apache.xerces/g' \
		xjc/src/com/sun/tools/xjc/GrammarLoader.java \
		xjc/src/com/sun/tools/xjc/reader/xmlschema/parser/SchemaConstraintChecker.java \
		xjc/src/com/sun/tools/xjc/reader/xmlschema/parser/XMLEntityResolverImpl.java \
		xjc/src/com/sun/tools/xjc/reader/xmlschema/parser/XMLFallthroughEntityResolver.java \
		xjc/src/com/sun/tools/xjc/GrammarLoader.java
	sed -i -e 's/com.sun.org.apache.xpath.internal/org.apache.xpath/g' \
		xjc/src/com/sun/tools/xjc/internalizer/Internalizer.java \
		xjc/src/com/sun/tools/xjc/reader/internalizer/Internalizer.java
	sed -i -e 's/com.sun.org.apache.xml.internal/org.apache.xml/g' \
		xjc/src/com/sun/tools/xjc/writer/Writer.java \
		xjc/src/com/sun/tools/xjc/generator/ObjectFactoryGenerator.java \
		xjc/src/com/sun/tools/xjc/generator/validator/ValidatorGenerator.java

	sed -i -e 's/reader.locator/reader.getLocator()/' \
		xjc/src/com/sun/tools/xjc/reader/decorator/RoleBasedDecorator.java

	sed -i -e 's/\(parent.getMaxOccurs()\)/\1.intValue()/' \
		xjc/src/com/sun/tools/xjc/reader/xmlschema/AlternativeParticleBinder.java

	sed -i -e 's/\(p.getMinOccurs()\)/\1.intValue()/g' \
		-e 's/\(p.getMaxOccurs()\)/\1.intValue()/g' \
		xjc/src/com/sun/tools/xjc/reader/xmlschema/BGMBuilder.java \
		xjc/src/com/sun/tools/xjc/reader/xmlschema/DefaultParticleBinder.java \
		xjc/src/com/sun/tools/xjc/reader/xmlschema/cs/ModelGroupBindingClassBinder.java \
		xjc/src/com/sun/tools/xjc/reader/xmlschema/ct/ChoiceComplexTypeBuilder.java

#	cd "${S}/lib"
#	rm -v *.jar || die
#	java-pkg_jarfrom --build-only ant-core ant.jar
#	java-pkg_jarfrom codemodel-2
#	java-pkg_jarfrom dom4j-1
#	java-pkg_jarfrom iso-relax
#	java-pkg_jarfrom msv
#	java-pkg_jarfrom relaxng-datatype
#	java-pkg_jarfrom xalan
#	java-pkg_jarfrom xerces-2
#	java-pkg_jarfrom xml-commons-resolver
#	java-pkg_jarfrom xsdlib
#	java-pkg_jarfrom xsom
#	cd "${S}/src/com/sun/"
#	rm -rf codemodel # in dev-java/codemodel
#	#rm -rf tools # in dev-java/jaxb-tools
#	cp -v "${FILESDIR}/build.xml-1.0.6-r1" "${S}/build.xml" || die "cp failed"
}

EANT_BUILD_TARGET="dist"

src_install() {
#	java-pkg_dojar dist/lib/jaxb-api.jar
	java-pkg_dojar dist/lib/jaxb-impl.jar
	java-pkg_dojar dist/lib/jaxb-xjc.jar
#	use source && java-pkg_dosrc src/*
}
