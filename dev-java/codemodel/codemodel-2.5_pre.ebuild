# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="source"

inherit java-pkg-2

DESCRIPTION="CodeModel is a Java library for code generators"
HOMEPAGE="https://codemodel.dev.java.net/"
SRC_URI="http://download.java.net/maven/2/com/sun/codemodel/codemodel/2.5-SNAPSHOT/codemodel-2.5-SNAPSHOT-sources.jar"

LICENSE="|| ( CDDL GPL-2 )"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

S="${WORKDIR}"

java_prepare() {
	rm -rf META-INF
}

src_compile() {
	local classes="${S}/target/classes"
	mkdir -p ${classes} || die
	#cd ${S}/src/main/java
	ejavac -d ${classes} $(find -name '*.java')
	jar cf ${S}/target/${PN}.jar -C ${classes} . || die "jar fail"
}

src_install() {
	java-pkg_dojar target/${PN}.jar
	use source && java-pkg_dosrc src/main/java/com
}
