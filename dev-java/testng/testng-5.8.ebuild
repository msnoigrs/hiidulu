# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="TestNG is a testing framework inspired from JUnit and NUnit"
HOMEPAGE="http://testng.org/"
SRC_URI="http://testng.org/${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/bsh:0
		dev-java/junit:0
		dev-java/qdox:1.6"

DEPEND=">=virtual/jdk-1.5
		dev-java/ant-core:0
		${CDEPEND}"
RDEPEND=">=virtual/jre-1.5
		${CDEPEND}"

#QDOX_NAME="qdox-1.6.1.jar"
#BSH_NAME="bsh-2.0b4.jar"

java_prepare() {
	find . -iname '*.jar' -exec rm -v {} +

	# Creaty empty jars to fool the unpacking
#	cd "${S}/3rdparty" || die
#	touch empty
#	jar cf ${QDOX_NAME} empty
#	jar cf ${BSH_NAME} empty

	sed -i -e 's/tag.getContext().getSource()/tag.getContext().getParent().getParentSource()/g' src/main/org/testng/internal/AnnotationTestConverter.java
	sed -i -e 's/writeFile(file, source.getPackage(), finalLines)/writeFile(file, source.getPackage().toString(), finalLines)/' src/main/org/testng/internal/AnnotationTestConverter.java

	sed -i -e '/fileset dir="\${lib.dir}"/a <include name="tools.jar"/>' build.xml
	sed -i -e '/fileset dir="\${lib.dir}"/a <include name="ant.jar"/>' build.xml
	java-pkg_jar-from --into 3rdparty bsh bsh.jar bsh-2.0b4.jar
	java-pkg_jar-from --into 3rdparty qdox-1.6 qdox.jar qdox-1.6.1.jar
	java-pkg_jar-from --into 3rdparty junit
	java-pkg_jar-from --into 3rdparty --build-only ant-core ant.jar
	ln -s $(java-config -t) 3rdparty/tools.jar
}

#JAVA_ANT_REWRITE_CLASSPATH="true"
#JAVA_ANT_CLASSPATH_TAGS="javac testng"

#EANT_GENTOO_CLASSPATH="bsh,qdox-1.6,ant-core,junit"
EANT_BUILD_TARGET="dist-15"
EANT_DOC_TARGET="javadocs"

src_install() {
	java-pkg_newjar "${P}-jdk15.jar" "${PN}.jar"
	java-pkg_register-ant-task

	use doc && java-pkg_dojavadoc javadocs/
	use source && java-pkg_dosrc src/jdk15/org/testng/
}

src_test() {
	eant -f test/build.xml run
}
