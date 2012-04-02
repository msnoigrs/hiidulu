# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="source doc"
WANT_ANT_TASKS="dev-java/package-rename-task:0
	dev-java/txw2:0
	dev-java/codemodel-annotation-compiler:0
	dev-java/istack-commons:0 ant-trax"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Reference implementation of the JAXB specification."
HOMEPAGE="http://jaxb.dev.java.net/"
#DATE="20090206"
#MY_P="JAXB2_src_${DATE}"
SRC_URI="http://jaxb.java.net/2.2.5/jaxb-ri-2.2.5.src.zip"

LICENSE="|| ( CDDL GPL-2 )"
SLOT="2.2"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="java-virtuals/stax-api
	java-virtuals/jaf
	dev-java/codemodel:2
	dev-java/txw2
	dev-java/istack-commons
	dev-java/xsom
	dev-java/rngom
	dev-java/relaxng-datatype
	dev-java/xsdlib
	dev-java/msv
	dev-java/iso-relax
	dev-java/args4j:1
	dev-java/fastinfoset
	dev-java/stax-ex
	dev-java/sun-dtdparser
	app-text/jing
	dev-java/xml-commons-external:1.4
	dev-java/xerces:2
	dev-java/xml-commons-resolver"
DEPEND=">=virtual/jdk-1.5
	dev-java/codemodel-annotation-compiler
	dev-java/relaxngcc
	dev-java/jaxb:1
	dev-java/ant-core
	${COMMON_DEP}"
#	dev-java/aptmirrorapi
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

#JAVA_PKG_NV_DEPEND="=virtual/jdk-1.5*"
#JAVA_PKG_WANT_SOURCE=1.5
#JAVA_PKG_WANT_TARGET=1.5
#JAVA_PKG_DEBUG="true"

S="${WORKDIR}"

#JAVA_PKG_BSFIX="off"
JAVA_PKG_BSFIX_ALL="yes"

java_prepare() {
	epatch "${FILESDIR}"/dontrunmvn.patch

#	jaxb_unpack_subpkg jaxb-api-2.2 tools/lib/redist2.2/jaxb-api-src.zip
	jaxb_unpack_subpkg jaxb-api tools/lib/redist/jaxb-api-src.zip
#	jaxb_unpack_subpkg resolver tools/lib/src/resolver-src.zip

	cd ${S}
#	epatch "${FILESDIR}"/2.1.9-no-package-rename.patch

#	find -depth -type d -name CVS -exec rm -rf {} \;
#	find -type f -name .cvsignore -delete
	find -type f -name '*.jar' -print -delete
	find -type f -name '*.class' -print -delete

#	rm -v tools/lib/redist2.2/*
	mv tools/lib/redist/jaxb-api-doc.zip ${T}
	rm -v tools/lib/redist/*
	mv ${T}/jaxb-api-doc.zip tools/lib/redist/

	sed -i -e '/^javac.compilerargs=.*$/d' nbproject/project.properties
	sed -i -e '/^runtime.compilerarg=.*$/d' build.properties
	echo "runtime.compilerarg=-Djava.endorsed.dirs=${S}/tools/lib/redist2.2" >> build.properties
	echo "javac.compilerargs=-endorseddirs ${S}/tools/lib/redist -J-Djava.endorsed.dirs=${S}/tools/lib/redist" >> nbproject/project.properties
	echo "codemodel.classes=codemodel.jar" >> build.properties
	echo "codemodel.classes=codemodel.jar" >> nbproject/project.properties

	java-ant_bsfix_one nbproject/build-impl.xml

#	java-pkg_jar-from --into ${S}/tools/lib/redist xml-commons-external-1.4
#	java-pkg_jar-from --into ${S}/tools/lib/redist xerces-2
#	java-pkg_jar-from --into ${S}/tools/lib/redist xml-commons-resolver xml-commons-resolver.jar resolver.jar
#	java-pkg_jar-from --into ${S}/tools/lib/redist istack-commons istack-commons-runtime.jar
#	java-pkg_jar-from --into ${S}/tools/lib/redist txw2 txw2.jar
#	java-pkg_jar-from --into ${S}/tools/lib/redist codemodel-2
	java-pkg_jar-from --into ${S}/tools/lib/redist --build-only xsdlib
#	java-pkg_jar-from --into ${S}/tools/lib/redist msv
	java-pkg_jar-from --into ${S}/tools/lib/redist --build-only relaxng-datatype
	ln -s $(java-config --tools) "${S}/tools/lib/redist/jam.jar" || die

	sed -i -e 's/com.sun.org.apache.xml.internal.resolver.CatalogManager/org.apache.xml.resolver.CatalogManager/' \
		-e 's/com.sun.org.apache.xml.internal.resolver.tools.CatalogResolver/org.apache.xml.resolver.tools.CatalogResolver/' \
		xjc/src/com/sun/tools/xjc/Options.java

	sed -i -e 's/com.sun.org.apache.xerces.internal/org.apache.xerces/' \
		xjc/src/com/sun/tools/xjc/SchemaCache.java

#	sed -i -e 's/com.thaiopensource.validate.IncorrectSchemaException/com.thaiopensource.relaxng.parse.IllegalSchemaException/' \
#		-e 's/IncorrectSchemaException/IllegalSchemaException/g' \
#		-e 's/com.thaiopensource.relaxng.impl.SchemaBuilderImpl/com.thaiopensource.relaxng.pattern.SchemaBuilderImpl/' \
#		-e 's/com.thaiopensource.relaxng.impl.SchemaPatternBuilder/com.thaiopensource.relaxng.pattern.SchemaPatternBuilder/' \
#		tools/jing-rnc-driver/src/com/thaiopensource/relaxng/jarv/RelaxNgCompactSyntaxVerifierFactory.java
	cp ${FILESDIR}/RelaxNgCompactSyntaxVerifierFactory.java tools/jing-rnc-driver/src/com/thaiopensource/relaxng/jarv/


	java-pkg_jar-from --into ${S}/tools/lib/util --build-only ant-core ant.jar
#	java-pkg_jar-from --into ${S}/tools/lib/util txw2 txwc2.jar
#	java-pkg_jar-from --into ${S}/tools/lib/util stax-ex

#	java-pkg_jar-from --into ${S}/runtime codemodel-2

	java-pkg_jar-from --into ${S}/tools/lib/util stax-ex
	java-pkg_jar-from --into ${S}/tools/lib/util args4j-1 args4j.jar args4j-1.0-RC.jar
	java-pkg_jar-from --into ${S}/tools/lib/util jing
	java-pkg_jar-from --into ${S}/tools/lib/util --build-only relaxngcc
	java-pkg_jar-from --into ${S}/tools/lib/util --build-only codemodel-annotation-compiler
	java-pkg_jar-from --into ${S}/tools/lib/util fastinfoset fastinfoset.jar FastInfoset.jar
	ln -s $(java-config --tools) "${S}/tools/lib/util/jam.jar" || die

	java-pkg_jar-from --into ${S}/tools/lib/rebundle/runtime2 istack-commons istack-commons-runtime.jar
	java-pkg_jar-from --into ${S}/tools/lib/rebundle/runtime2 txw2 txw2.jar

	java-pkg_jar-from --into ${S}/tools/lib/rebundle/compiler xml-commons-resolver xml-commons-resolver.jar resolver.jar
	java-pkg_jar-from --into ${S}/tools/lib/rebundle/compiler rngom
	java-pkg_jar-from --into ${S}/tools/lib/rebundle/compiler istack-commons istack-commons-tools.jar
	java-pkg_jar-from --into ${S}/tools/lib/rebundle/compiler codemodel-2
	java-pkg_jar-from --into ${S}/tools/lib/rebundle/compiler sun-dtdparser dtd-parser.jar dtd-parser-1.0.jar
	java-pkg_jar-from --into ${S}/tools/lib/rebundle/compiler relaxng-datatype
	java-pkg_jar-from --into ${S}/tools/lib/rebundle/compiler xsom

	java-pkg_jar-from --into ${S}/tools/lib/rebundle/runtime iso-relax
	java-pkg_jar-from --into ${S}/tools/lib/rebundle/runtime xsdlib
	java-pkg_jar-from --into ${S}/tools/lib/rebundle/runtime msv
	java-pkg_jar-from --into ${S}/tools/lib/rebundle/runtime relaxng-datatype


	java-pkg_jar-from --into ${S}/tools/compiler10 --build-only jaxb-1 jaxb-xjc.jar jaxb1-xjc.jar

#	java-pkg_jar-from --into ${S}/tools/lib/util --build-only aptmirrorapi aptmirrorapi.jar jam.jar
}

jaxb_unpack_subpkg() {
	local subdir="$1" archive="$2"
	shift 2
	mkdir "${WORKDIR}/${subdir}"{,/src,/classes} || die
	cd "${WORKDIR}/${subdir}/src" || die
	echo "Unpacking ${archive} to ${PWD}"
	unzip -qq "${S}/${archive}" || die "Error unzipping ${archive}"
	cd "${S}" || die
}

jaxb_compile_subpkg1() {
		local subdir="$1" jar="$2" deps="$3" file
		shift 2
		einfo "Compiling ${subdir}"
		cd "${WORKDIR}/${subdir}" || die
		local classpath="${deps:+$(java-pkg_getjars ${deps})}"
		ejavac ${classpath:+-classpath "${classpath}"} \
		-Xbootclasspath/p:${WORKDIR}/jaxb-api-2.2/classes \
				 -encoding UTF-8 -d classes $(find src -name \*.java)
		echo "${subdir} recompiled from source"
		for file in $(find src -name \*.properties); do
				mkdir -p classes/$(dirname ${file#src/}) || die
				cp ${file} classes/${file#src/} || die
		done
		jar cf "${S}/${jar}" -C classes . || die "jar failed"
		echo "${subdir} packaged"
		cd "${S}" || die
}

jaxb_compile_subpkg2() {
		local subdir="$1" jar="$2" deps="$3" file
		shift 2
		einfo "Compiling ${subdir}"
		cd "${WORKDIR}/${subdir}" || die
		local classpath="${deps:+$(java-pkg_getjars ${deps})}"
		ejavac ${classpath:+-classpath "${classpath}"} \
		-Xbootclasspath/p:${WORKDIR}/jaxb-api/classes \
				 -encoding UTF-8 -d classes $(find src -name \*.java)
		echo "${subdir} recompiled from source"
		for file in $(find src -name \*.properties); do
				mkdir -p classes/$(dirname ${file#src/}) || die
				cp ${file} classes/${file#src/} || die
		done
		jar cf "${S}/${jar}" -C classes . || die "jar failed"
		echo "${subdir} packaged"
		cd "${S}" || die
}

jaxb_compile_subpkg3() {
		local subdir="$1" jar="$2" file
		shift 2
		einfo "Compiling ${subdir}"
		cd "${WORKDIR}/${subdir}" || die
		ejavac \
		-Xbootclasspath/p:${WORKDIR}/resolver/classes \
				 -encoding UTF-8 -d classes $(find src -name \*.java)
		echo "${subdir} recompiled from source"
		for file in $(find src -name \*.properties); do
				mkdir -p classes/$(dirname ${file#src/}) || die
				cp ${file} classes/${file#src/} || die
		done
		jar cf "${S}/${jar}" -C classes . || die "jar failed"
		echo "${subdir} packaged"
		cd "${S}" || die
}

EANT_BUILD_TARGET="dist"

src_compile() {
#	jaxb_compile_subpkg3 resolver tools/lib/redist2.2/resolver.jar
#	jaxb_compile_subpkg1 jaxb-api-2.2 tools/lib/redist2.2/jaxb-api.jar jaf,stax-api
#	eant clean

	jaxb_compile_subpkg2 jaxb-api tools/lib/redist/jaxb-api.jar jaf,stax-api

#	cp ${S}/tools/lib/redist2.2/resolver.jar ${S}/tools/lib/rebundle/compiler

#	local antopts="-Djava.endorsed.dirs=${S}/tools/lib/redist2.2"
	local antopts="-Djava.endorsed.dirs=${S}/tools/lib/redist"
	export ANT_OPTS=${antopts}
	java-pkg-2_src_compile
}

src_install() {
#	java-pkg_dojar tools/lib/redist2.2/jaxb-api.jar
	java-pkg_dojar tools/lib/redist/jaxb-api.jar
	cd dist/lib || die
	#java-pkg_dojar jaxb-api.jar
	java-pkg_dojar jaxb-impl.jar
	java-pkg_dojar jaxb-xjc.jar
	java-pkg_register-ant-task

	local java_args="-Djava.endorsed.dirs=/usr/share/jaxb-${SLOT}/lib"

	java-pkg_dolauncher "xjc-${SLOT}" --jar jaxb-xjc.jar \
		--main com.sun.tools.xjc.Driver \
		--pkg_args "${java_args}"
	java-pkg_dolauncher "schemagen-${SLOT}" --jar jaxb-xjc.jar \
		--main com.sun.tools.xjc.SchemaGeneratorFacade \
		--pkg_args "${java_args}"

	cd ${S}  || die
	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc runtime/src/* xjc/src/*
}
