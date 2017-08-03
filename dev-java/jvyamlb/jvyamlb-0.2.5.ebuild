# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="source test"
inherit java-pkg-2 java-ant-2

DESCRIPTION="JvYAMLb, YAML processor extracted from JRuby"
HOMEPAGE="http://code.google.com/p/jvyamlb/"
#SRC_URI="http://jvyamlb.googlecode.com/files/jvyamlb-src-${PV}.tar.gz"
SRC_URI="https://github.com/olabini/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

CDEPEND="dev-java/bytelist:1.0.14
	dev-java/joda-time:0
	dev-java/jcodings:0"
RDEPEND=">=virtual/jre-1.6
	${CDEPEND}"

DEPEND=">=virtual/jdk-1.6
	test? ( dev-java/ant-junit )
	${CDEPEND}"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="bytelist-1.0.14 joda-time jcodings"

java_prepare() {
	rm -fv lib/*.jar || die

	# Don't do tests unnecessarily.
	sed -i 's:depends="test":depends="compile":' build.xml
}

src_install() {
	java-pkg_newjar lib/${P}.jar
	use source && java-pkg_dosrc src/*
}

src_test() {
	ANT_TASKS="ant-junit" eant test
}
