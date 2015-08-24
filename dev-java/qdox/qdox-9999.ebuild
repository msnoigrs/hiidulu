# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
EGIT_REPO_URI="https://github.com/paul-hammant/qdox.git"
JAVA_PKG_IUSE="doc source junit"

inherit git-2 java-pkg-2 java-ant-2

DESCRIPTION="Parser for extracting class/interface/method definitions from source files with JavaDoc tags."
SRC_URI=""
HOMEPAGE="http://qdox.codehaus.org/"
LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEP="junit? ( dev-java/junit:4 )"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}
	dev-java/ant-core
	>=dev-java/byaccj-1.14
	dev-java/jflex:1.6.1
	sys-apps/sed"

java_prepare() {
	sed -i -s 's/JFlexLexer( sourceStream )/JFlexLexer( new java.io.InputStreamReader(sourceStream) )/' src/main/java/com/thoughtworks/qdox/library/ClassLoaderLibrary.java

	find . -depth -name .svn -type d -delete

	mkdir lib || die
	cd lib
	java-pkg_jarfrom --build-only ant-core ant.jar

#	if use junit; then
#		java-pkg_jarfrom junit-4 junit.jar
#	else
#		rm -rf ${S}/src/java/com/thoughtworks/qdox/junit
#	fi
}

src_compile() {
#	sed -i -e 's/yy_lexical_state/zzLexicalState/g' src/grammar/lexer.flex
#	local impldir="src/java/com/thoughtworks/qdox/parser/impl"
	local impldir="src/main/java/com/thoughtworks/qdox/parser/impl"
	mkdir -p ${impldir}
#	jflex -d ${impldir} --skel src/grammar/skeleton.inner src/grammar/lexer.flex || die "jflex failed"
	jflex-1.6.1 -d ${impldir} src/grammar/lexer.flex || die "jflex failed"
	jflex-1.6.1 -d ${impldir} src/grammar/commentlexer.flex || die "jflex failed"
	byaccj -v -Jnorun -Jnoconstruct -Jclass=DefaultJavaCommentParser \
		-Jpackage=com.thoughtworks.qdox.parser.impl \
		src/grammar/commentparser.y || die "byaccj failed"
	byaccj -v -Jnorun -Jnoconstruct -Jclass=Parser -Jsemantic=Value \
		-Jpackage=com.thoughtworks.qdox.parser.impl \
		-Jstack=500 \
		src/grammar/parser.y || die "byaccj failed"

	sed -i -s 's/this( stream )/this( new java.io.InputStreamReader(stream) )/' src/main/java/com/thoughtworks/qdox/parser/impl/JFlexLexer.java

	sed -i -e 's/\(public class Parser\)/\1 implements CommentHandler/' Parser.java
	mv Parser.java ${impldir} || die
	mv DefaultJavaCommentParser.java ${impldir} || die
	mv DefaultJavaCommentParserVal.java ${impldir} || die

	local classes="${S}/target/classes"
	local javadocdir="${S}/dist/docs/api"
	local cps="${S}/lib/ant.jar"
	cps="${cps}:${S}/lib/junit.jar"
	cps="${cps}:."

	cd ${S}
	mkdir -p ${classes}
#	cd ${S}/src/java
	cd ${S}/src/main/java

	ejavac -d ${classes} -cp ${cps} $(find -name "*.java")

	jar cf ${S}/target/${PN}.jar -C ${classes} . || die "cannot create jar"

	if use doc; then
		mkdir -p ${javadocdir}
		srcdirs="com.thoughtworks.qdox
				com.thoughtworks.qdox.ant
				com.thoughtworks.qdox.directorywalker
				com.thoughtworks.qdox.model
				com.thoughtworks.qdox.model.annotation
				com.thoughtworks.qdox.model.util
				com.thoughtworks.qdox.parser
				com.thoughtworks.qdox.parser.impl
				com.thoughtworks.qdox.parser.structs
				com.thoughtworks.qdox.tools"
		if use junit; then
			srcdirs="${srcdirs} com.thoughtworks.qdox.junit"
		fi

		javadoc -classpath ${cps} -d ${javadocdir} ${srcdirs}
	fi
}

src_install() {
	java-pkg_dojar target/${PN}.jar
	java-pkg_register-ant-task

	use doc && java-pkg_dohtml -r dist/docs/api
	use source && java-pkg_dosrc src/main/java/com
}
