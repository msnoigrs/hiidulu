# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-ivy:2"

ESVN_REPO_URI="https://ant-contrib.svn.sourceforge.net/svnroot/ant-contrib/ant-contrib/trunk"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="The Ant-Contrib project is a collection of tasks (and at one point maybe types and other tools) for Apache Ant."
HOMEPAGE="http://ant-contrib.sourceforge.net/"
SRC_URI=""
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

#	test? ( dev-java/ant-junit dev-java/ant-testutil )
RDEPEND=">=virtual/jre-1.5
	>=dev-java/bcel-5.1:0
	dev-java/commons-httpclient:3
	dev-java/xerces:2
	dev-java/ant-ivy:2"
# javatoolkit for cElementTree
DEPEND=">=virtual/jdk-1.5
	dev-java/ant-ivy:0
	>=dev-java/ant-core-1.7.0
	${RDEPEND}"

java_prepare() {
	sed -i -e '/<pathelement location=\"${ant.jar}\"/a <pathelement location=\"\${xerces.jar}\"></pathelement>' build.xml
	sed -i -e '/<pathelement location=\"${ant.jar}\"/a <pathelement location=\"\${ivy2.jar}\"></pathelement>' build.xml
	epatch "${FILESDIR}/tests-visibility.patch"
	find -name "*.jar" -print -delete || die
#	rm -v src/main/java/net/sf/antcontrib/net/Ivy14Adapter.java
}

# Can't load bcel for some reason
RESTRICT="test"

src_compile() {
	eant -Dno-ivy=true \
		-Dant.jar="$(java-pkg_getjar --build-only ant-core ant.jar)" \
		-Divy.jar="$(java-pkg_getjar --build-only ant-ivy ivy.jar)" \
		-Divy2.jar="$(java-pkg_getjar ant-ivy-2 ivy.jar)" \
		-Dhttpclient.jar="$(java-pkg_getjar commons-httpclient-3 commons-httpclient.jar)" \
		-Dbcel.jar="$(java-pkg_getjar bcel bcel.jar)" \
		-Dxerces.jar="$(java-pkg_getjar xerces-2 xercesImpl.jar)" \
		-Dproject.version=snapshot jar $(use_doc)
}

src_install() {
	java-pkg_dojar target/${PN}.jar

	java-pkg_register-ant-task
	use doc && java-pkg_dojavadoc target/docs/api
	use source && java-pkg_dosrc src/java/net
	java-pkg_dohtml -r docs/manual
}
