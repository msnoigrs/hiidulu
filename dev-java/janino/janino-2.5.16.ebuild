# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Embedded run-time Java compiler."
HOMEPAGE="http://janino.net/
http://docs.codehaus.org/display/JANINO/Home"
SRC_URI="http://dist.codehaus.org/janino/${P}.zip"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5
	dev-java/ant-core"

java_prepare() {
	rm -v lib/janino.jar

	# Remove hardcoded paths like "C:\jdk1.2"
	edos2unix build.xml
	epatch "${FILESDIR}/build-remove-hardcoded-${PV}.patch" || die
}

JAVA_ANT_REWRITE_CLASSPATH="yes"

src_compile() {
	EANT_EXTRA_ARGS="-Dgentoo.classpath=$(java-pkg_getjar --build-only ant-core ant.jar)" \
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar "build/lib/${PN}.jar"

	java-pkg_register-ant-task
	use doc && java-pkg_dojavadoc build/javadoc
	use source && java-pkg_dosrc src
}
