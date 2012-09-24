# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

JAVA_PKG_IUSE="doc source"

#EHG_REPO_URI="https://bitbucket.org/validator/validator"

inherit mercurial java-pkg-2 java-ant-2

DESCRIPTION="An HTML5 conformance checker."
HOMEPAGE="http://about.validator.nu/"
#SRC_URI="local-entities.tar.bz2"
#grep -v schema/ e.txt | { while read l; do u=$(echo ${l} | cut -d ' ' -f 1); dd=$(echo ${l} | cut -d ' ' -f 2); [[ ! -d $(dirname local-entities/${dd}) ]] && mkdir -p local-entities/$(dirname ${dd}); wget -O local-entities/${dd} ${u}; done }
#tar jcf local-entities.tar.bz2 local-entites
SRC_URI=""
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

COMMON_DEP="dev-java/validator-nu-util
	dev-java/validator-nu-htmlparser
	dev-java/validator-nu-html5-datatypes
	dev-java/validator-nu-non-schema
	dev-java/validator-nu-xmlparser
	app-text/validator-nu-jing
	dev-java/commons-fileupload
	dev-java/relaxng-datatype
	dev-java/iri
	dev-java/icu4j:49
	dev-java/log4j-over-slf4j"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	java-virtuals/servlet-api:3.0
	${COMMON_DEP}"

src_unpack() {
	mkdir -p ${S}

	mercurial_fetch https://bitbucket.org/validator/validator validator ${S}/validator
	mercurial_fetch https://bitbucket.org/validator/syntax syntax ${S}/syntax

	mercurial_fetch https://bitbucket.org/validator/build build ${S}/build

	mercurial_fetch https://dvcs.w3.org/hg/nu-validator-site nu-validator-site ${S}/nu-validator-site

	cd ${S}
#	unpack ${A}
	cat validator/entity-map.txt | grep -v schema/ | { while read l; do u=$(echo ${l} | cut -d ' ' -f 1); dd=$(echo ${l} | cut -d ' ' -f 2); [[ ! -d $(dirname local-entities/${dd}) ]] && mkdir -p local-entities/$(dirname ${dd}); wget -O local-entities/${dd} ${u}; done }
}

java_prepare() {
	find -name '.cvsignore' -delete

	sed -i -e "/elif arg == 'all':/ i \    elif arg == 'prepareebuild':\n      buildSchemaDrivers()\n      prepareLocalEntityJar()" build/build.py

	python build/build.py prepareebuild

#	local fdir="validator/src/nu/validator/localentities/files"
#	mkdir -p ${fdir}
#	cp validator/presets.txt ${fdir}/presets
#	cp validator/spec/html5.html ${fdir}/html5spec
#
#	while read line; do
#		u=$(echo ${line} | cut -d ' ' -f 1)
#		p=$(echo ${line} | cut -d ' ' -f 2)
#		entpath=""
#		if [[ "${p}" =~ "schema/html5/" ]]; then
#			entpath="syntax/relaxng/${p: 13}"
#		elif [[ "${p}" =~ "schema" ]]; then
#			entpath="validator/${p}"
#		else
#			entpath="local-entities/${p}"
#		fi
#		safename=$(echo "${p}" | sed -e 's/[^a-zA-Z0-9]/_/g')
#		safepath="${fdir}/${safename}"
#		if [[ -f "${entpath}" ]]; then
#			printf '%s\t%s\n' "${u}" "${safename}" >> "${fdir}"/entitymap
#			cp ${entpath} ${safepath}
#		else
#			echo $entpath
#		fi
#	done < validator/entity-map.txt

	mkdir lib && cd lib

	java-pkg_jar-from validator-nu-util
	java-pkg_jar-from validator-nu-htmlparser htmlparser.jar
	java-pkg_jar-from validator-nu-html5-datatypes
	java-pkg_jar-from validator-nu-non-schema
	java-pkg_jar-from validator-nu-xmlparser
	java-pkg_jar-from validator-nu-jing jing.jar
	java-pkg_jar-from commons-fileupload
	java-pkg_jar-from relaxng-datatype
	java-pkg_jar-from iri
	java-pkg_jar-from icu4j-49 icu4j.jar
	java-pkg_jar-from log4j-over-slf4j
	java-pkg_jar-from --virtual --build-only servlet-api-3.0 servlet-api.jar

	cd ${S}
	pageTemplate="validator/xml-src/PageEmitter.xml"
	pageEmitter="validator/src/nu/validator/servlet/PageEmitter.java"
	formTemplate="validator/xml-src/FormEmitter.xml"
	formEmitter="validator/src/nu/validator/servlet/FormEmitter.java"
	w3cPageTemplate="nu-validator-site/w3cPageEmitter.xml"
	w3cPageEmitter="validator/src/nu/validator/servlet/W3CPageEmitter.java"
	w3cFormTemplate="nu-validator-site/w3cFormEmitter.xml"
	w3cFormEmitter="validator/src/nu/validator/servlet/W3CFormEmitter.java"
	java -classpath lib/io-xml-util.jar nu.validator.tools.SaxCompiler ${pageTemplate} ${pageEmitter}
	java -classpath lib/io-xml-util.jar nu.validator.tools.SaxCompiler ${formTemplate} ${formEmitter}
	java -classpath lib/io-xml-util.jar nu.validator.tools.SaxCompiler ${w3cPageTemplate} ${w3cPageEmitter}
	java -classpath lib/io-xml-util.jar nu.validator.tools.SaxCompiler ${w3cFormTemplate} ${w3cFormEmitter}

	cp "${FILESDIR}/gentoo-build.xml" build.xml


	rm -v validator/src/nu/validator/servlet/Main.java
}

EANT_EXTRA_ARGS="-Dproject.name=validator"

src_install() {
	java-pkg_dojar target/validator.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc validator/src/*
}
